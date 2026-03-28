/// Point d’entrée de la configuration runtime.
///
/// Tant que le backend n’est pas prêt : garder [useMockBackend] à `true`.
/// Pour pointer vers l’API réelle : `false` + implémenter les `Remote*Repository`.
class AppConfig {
  AppConfig._();

  /// Peut être surchargé via :
  /// `flutter run --dart-define=USE_MOCK_BACKEND=false`
  static const bool useMockBackend = bool.fromEnvironment(
    'USE_MOCK_BACKEND',
    defaultValue: true,
  );
}
