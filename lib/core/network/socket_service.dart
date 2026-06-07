import 'dart:async';
import 'dart:convert';

import 'package:flutter_template/core/auth/i_session_service.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/io.dart';
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
  bool _isConnecting = false;

  SocketService(this._sessionService);

  /// Stream of incoming messages
  Stream<dynamic> get messages => _messageController.stream;

  /// Connection status
  bool get isConnected => _isConnected && _channel != null;

  /// Connect to the WebSocket server
  Future<void> connect(String url) async {
    if (_isConnected || _isConnecting || _channel != null) {
      print(
        'SocketService: Already connecting or connected to $_currentUrl. Skipping new connection to $url.',
      );
      return;
    }

    _isConnecting = true;
    _currentUrl = url;
    _isManuallyClosed = false;

    try {
      final token = await _sessionService.getAccessToken();
      if (token == null) {
        print('SocketService: No token found, scheduling reconnect');
        _isConnecting = false;
        _scheduleReconnect();
        return;
      }

      final uri = Uri.parse(url);
      print('SocketService: Connecting to $url...');

      _channel = IOWebSocketChannel.connect(
        uri,
        headers: {'Authorization': 'Bearer $token'},
        pingInterval: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 10),
      );

      // Set connected to true as the channel is now active
      _isConnected = true;

      _subscription = _channel!.stream.listen(
        (message) {
          _reconnectAttempts = 0;
          _onMessageReceived(message);
        },
        onError: (error) {
          print('SocketService: Stream error: $error');
          _handleConnectionError(error);
        },
        onDone: () {
          print('SocketService: Stream done');
          _handleConnectionDone();
        },
        cancelOnError: true,
      );
    } catch (e) {
      print('SocketService: Connection exception: $e');
      _handleConnectionError(e);
    } finally {
      _isConnecting = false;
    }
  }

  void sendChatMessage(String chatId, String content) {
    sendMessage({
      'type': 'SEND_MESSAGE',
      'payload': {'chatId': chatId, 'content': content, 'type': 'text'},
    });
  }

  /// Notify that user started typing in a chat
  void sendTypingStart(String chatId) {
    sendMessage({
      'type': 'TYPING_START',
      'payload': {
        'chatId': chatId,
      },
    });
  }

  /// Notify that user stopped typing in a chat
  void sendTypingStop(String chatId) {
    sendMessage({
      'type': 'TYPING_STOP',
      'payload': {
        'chatId': chatId,
      },
    });
  }

  /// Send a JSON message
  void sendMessage(Map<String, dynamic> data) {
    if (_channel != null && _isConnected) {
      try {
        _channel!.sink.add(jsonEncode(data));
      } catch (e) {
        print('SocketService: Error sending message: $e');
        _handleConnectionError(e);
      }
    } else {
      print('SocketService: Cannot send message, not connected');
    }
  }

  /// Manually disconnect from the server
  void disconnect() {
    print('SocketService: Manually disconnecting');
    _isManuallyClosed = true;
    _cleanup();
  }

  void _onMessageReceived(dynamic message) {
    try {
      final decoded = jsonDecode(message.toString());
      _messageController.add(decoded);
    } catch (e) {
      print('SocketService: Error decoding message: $e');
    }
  }

  void _handleConnectionError(dynamic error) {
    _cleanup();
    _scheduleReconnect();
  }

  void _handleConnectionDone() {
    _cleanup();
    if (!_isManuallyClosed) {
      _scheduleReconnect();
    }
  }

  void _cleanup() {
    _isConnected = false;
    _isConnecting = false;
    _reconnectTimer?.cancel();
    _subscription?.cancel();
    _channel?.sink.close();
    _channel = null;
  }

  void _scheduleReconnect() {
    if (_isManuallyClosed || (_reconnectTimer?.isActive ?? false)) return;

    _reconnectAttempts++;
    final delay = _getBackoffDelay();
    print(
      'SocketService: Reconnecting in ${delay.inSeconds}s (Attempt $_reconnectAttempts)',
    );

    _reconnectTimer = Timer(delay, () {
      if (_currentUrl != null && !_isManuallyClosed) {
        connect(_currentUrl!);
      }
    });
  }

  Duration _getBackoffDelay() {
    if (_reconnectAttempts <= 1) return const Duration(seconds: 2);
    if (_reconnectAttempts == 2) return const Duration(seconds: 5);
    return const Duration(seconds: 10);
  }

  /// Clean up resources when the service is destroyed
  @disposeMethod
  void dispose() {
    disconnect();
    _messageController.close();
  }
}
