import 'package:get_storage/get_storage.dart';

/// Local storage for non-sensitive data.
/// Auth tokens should use flutter_secure_storage (see SecureStorage utility).
final interne_storage = GetStorage();