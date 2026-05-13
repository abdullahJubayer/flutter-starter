import 'dart:async';
import 'dart:convert';
import 'package:flutter_template/core/auth/i_session_service.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@lazySingleton
class SocketService {
  final ISessionService _sessionService;

  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  Timer? _reconnectTimer;

  final _messageController = StreamController<dynamic>.broadcast();
  bool _isConnected = false;
  bool _isManuallyClosed = false;
  int _reconnectAttempts = 0;
  String? _currentUrl;

  SocketService(this._sessionService);

  /// Stream of incoming messages
  Stream<dynamic> get messages => _messageController.stream;

  /// Connection status
  bool get isConnected => _isConnected;

  /// Connect to the WebSocket server
  Future<void> connect(String url) async {
    if (_isConnected || _channel != null) {
      return; // Already connecting or connected
    }

    _currentUrl = url;
    _isManuallyClosed = false;

    final token = await _sessionService.getAccessToken();
    if (token == null) {
      _scheduleReconnect();
      return;
    }

    try {
      final uri = Uri.parse(url).replace(queryParameters: {'token': token});
      _channel = WebSocketChannel.connect(uri);
      _isConnected = true;
      _reconnectAttempts = 0;

      _subscription = _channel!.stream.listen(
        (message) => _onMessageReceived(message),
        onError: (error) => _handleConnectionError(error),
        onDone: () => _handleConnectionDone(),
        cancelOnError: true,
      );
    } catch (e) {
      _handleConnectionError(e);
    }
  }

  /// Send a JSON message
  void sendMessage(Map<String, dynamic> data) {
    if (_channel != null && _isConnected) {
      try {
        _channel!.sink.add(jsonEncode(data));
      } catch (e) {
        _handleConnectionError(e);
      }
    }
  }

  /// Manually disconnect from the server
  void disconnect() {
    _isManuallyClosed = true;
    _reconnectTimer?.cancel();
    _subscription?.cancel();
    _channel?.sink.close();
    _channel = null;
    _isConnected = false;
  }

  void _onMessageReceived(dynamic message) {
    try {
      final decoded = jsonDecode(message.toString());
      _messageController.add(decoded);
    } catch (e) {
      // Log parsing error but keep connection alive
      print('SocketService: Error decoding message: $e');
    }
  }

  void _handleConnectionError(dynamic error) {
    print('SocketService: Connection error: $error');
    _cleanup();
    _scheduleReconnect();
  }

  void _handleConnectionDone() {
    print('SocketService: Connection closed');
    _cleanup();
    if (!_isManuallyClosed) {
      _scheduleReconnect();
    }
  }

  void _cleanup() {
    _subscription?.cancel();
    _channel = null;
    _isConnected = false;
  }

  void _scheduleReconnect() {
    if (_isManuallyClosed || (_reconnectTimer?.isActive ?? false)) return;

    _reconnectAttempts++;
    final delay = _getBackoffDelay();
    print('SocketService: Reconnecting in ${delay.inSeconds}s (Attempt $_reconnectAttempts)');

    _reconnectTimer = Timer(delay, () {
      if (_currentUrl != null) {
        connect(_currentUrl!);
      }
    });
  }

  Duration _getBackoffDelay() {
    if (_reconnectAttempts <= 1) return const Duration(seconds: 1);
    if (_reconnectAttempts == 2) return const Duration(seconds: 2);
    if (_reconnectAttempts == 3) return const Duration(seconds: 5);
    return const Duration(seconds: 10);
  }

  /// Clean up resources when the service is destroyed
  @disposeMethod
  void dispose() {
    disconnect();
    _messageController.close();
  }
}
