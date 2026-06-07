import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'i_logger.dart';

class DefaultLogger implements ILogger {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: false,
      printEmojis: false,
      stackTraceBeginIndex: 1
    ),
  );

  @override
  Future<void> init() async {}

  @override
  void d({
    required String? message,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.d(
      _formatMessage(message, tag),
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void e({
    required Object? error,
    String? message,
    String? tag,
    StackTrace? stackTrace,
  }) {
    _logger.e(
      _formatMessage(message, tag),
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void i({
    required String? message,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.i(
      _formatMessage(message, tag)
    );
  }

  @override
  void w({
    required String? message,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.w(
      _formatMessage(message, tag),
      error: error
    );
  }

  String _formatMessage(String? message, String? tag) {
    if (tag != null && tag.isNotEmpty) {
      return '[$tag] ${message ?? ''}';
    }
    return message ?? '';
  }
}
