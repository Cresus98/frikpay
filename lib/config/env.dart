/// Configuration injectable au build (pas de secrets versionnés en prod).
///
/// Exemple :
/// ```bash
/// flutter run --dart-define=FRIKPAY_BASE_URL=https://api.example.com/ \
///   --dart-define=FRIKPAY_BEARER_USER=app \
///   --dart-define=FRIKPAY_BEARER_PASSWORD=secret
/// ```
abstract final class Env {
  Env._();

  static String get frikpayBaseUrl => const String.fromEnvironment(
        'FRIKPAY_BASE_URL',
        defaultValue: 'https://api.friklabel.com/',
      );

  static String get headerCode => const String.fromEnvironment(
        'FRIKPAY_HEADER_CODE',
        defaultValue: 'CODEX@123',
      );

  static String get bearerUsername => const String.fromEnvironment(
        'FRIKPAY_BEARER_USER',
        defaultValue: 'flutter',
      );

  static String get bearerUsernameReset => const String.fromEnvironment(
        'FRIKPAY_BEARER_USER_RESET',
        defaultValue: 'web',
      );

  static String get bearerPassword => const String.fromEnvironment(
        'FRIKPAY_BEARER_PASSWORD',
        defaultValue: 'dvxhzdbppk-flutter',
      );
}
