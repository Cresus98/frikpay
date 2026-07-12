import 'package:flutter/foundation.dart';

/// Safe logger — only outputs in debug mode, never in release.
/// Use this instead of `print()` throughout the codebase.
abstract final class AppLogger {
  AppLogger._();

  static void d(String message) {
    if (kDebugMode) {
      debugPrint('[FrikPay] $message');
    }
  }

  static void e(String message, [Object? error]) {
    if (kDebugMode) {
      debugPrint('[FrikPay ERROR] $message${error != null ? ': $error' : ''}');
    }
  }
}
