import 'package:dio/dio.dart';
import 'package:flutter_template/feature/auth/domain/model/base_response.dart';

extension ErrorMessageExtension on Object {
  /// Extracts a user-friendly error message from common error shapes.
  ///
  /// - If `this` is a [DioException] and the response contains an `errors`
  ///   map (each value a list of messages), it aggregates messages and
  ///   returns the first three messages joined by newline when there are
  ///   more than three.
  /// - If the response contains a standard `message`/`errors` payload,
  ///   it falls back to [BaseResponse.fromError] and applies the same
  ///   "first 3 messages" rule to multi-line messages.
  /// - Otherwise returns the exception message or `toString()`.
  String extractErrorMessage() {
    if (this is DioException) {
      final err = this as DioException;
      final responseData = err.response?.data;

      if (responseData is Map<String, dynamic>) {
        // Prefer structured `errors` map when present
        final rawErrors = responseData['errors'];
        if (rawErrors is Map<String, dynamic>) {
          final messages = <String>[];
          rawErrors.forEach((_, v) {
            if (v is List) {
              messages.addAll(v.map((e) => e.toString()));
            } else if (v != null) {
              messages.add(v.toString());
            }
          });

          if (messages.isNotEmpty) {
            final take = messages.length > 3 ? messages.sublist(0, 3) : messages;
            return take.join('\n');
          }
        }

        // Fallback to BaseResponse.fromError which normalizes message/errors
        try {
          final base = BaseResponse.fromError(responseData);
          final raw = base.error;
          final parts = raw
              .split('\n')
              .map((s) => s.trim())
              .where((s) => s.isNotEmpty)
              .toList();
          if (parts.length > 3) return parts.sublist(0, 3).join('\n');
          return raw;
        } catch (_) {
          // ignore and fall through
        }
      }

      return err.message ?? 'Action failed. Please try again.';
    }

    return toString();
  }
}

