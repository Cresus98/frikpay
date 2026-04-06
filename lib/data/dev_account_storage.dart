import 'package:get_storage/get_storage.dart';

/// Persistance locale du compte développeur sélectionné (en attendant l’API).
final class DevAccountStorage {
  DevAccountStorage._();

  static const String accountIdKey = 'selected_dev_account_id';

  static String? readId() {
    final raw = GetStorage().read(accountIdKey);
    if (raw is String && raw.isNotEmpty) return raw;
    return null;
  }

  static void writeId(String id) {
    GetStorage().write(accountIdKey, id);
  }

  static void clear() {
    GetStorage().remove(accountIdKey);
  }
}
