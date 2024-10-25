import 'package:flutter/foundation.dart';

/// Super simple logger class that prints errors to the console.
class Logger {
  static void error({
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      debugPrint('Error: $error | StackTrace: $stackTrace');
    }
  }
}
