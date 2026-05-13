import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'i_logger.dart';

class DefaultLogger implements ILogger {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true, // Should each log print contain a timestamp
      stackTraceBeginIndex: 1, // Skip the first frame (DefaultLogger)
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
      _formatMessage(message, tag),
      error: error,
      stackTrace: stackTrace,
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
      error: error,
      stackTrace: stackTrace,
    );
  }

  String _formatMessage(String? message, String? tag) {
    if (tag != null && tag.isNotEmpty) {
      return '[$tag] ${message ?? ''}';
    }
    return message ?? '';
  }
}
