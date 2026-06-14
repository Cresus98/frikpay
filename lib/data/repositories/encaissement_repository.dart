import 'package:fripay/config/app_config.dart';
import 'package:fripay/models/encaissement_entry.dart';

/// Contrat données encaissements — mock ou API.
abstract class EncaissementRepository {
  Future<List<EncaissementEntry>> list();

  /// Crée une demande d’encaissement (statut initial géré par l’implémentation).
  Future<EncaissementEntry> create({
    required String method,
    required String phone,
    String? extraNote,
  });

  static EncaissementRepository createDefault() {
    return AppConfig.useMockBackend
        ? MockEncaissementRepository()
        : RemoteEncaissementRepository();
  }
}

/// Données locales pour développement / démo.
class MockEncaissementRepository implements EncaissementRepository {
  final List<EncaissementEntry> _items = [
    EncaissementEntry(
      id: 'enc-001',
      method: 'MTN Mobile Money',
      phone: '+229 97 00 00 01',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      status: EncaissementStatus.termine,
    ),
  ];

  @override
  Future<List<EncaissementEntry>> list() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return List<EncaissementEntry>.from(_items);
  }

  @override
  Future<EncaissementEntry> create({
    required String method,
    required String phone,
    String? extraNote,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final e = EncaissementEntry(
      id: 'enc-${DateTime.now().millisecondsSinceEpoch}',
      method: method,
      phone: phone,
      createdAt: DateTime.now(),
      status: EncaissementStatus.enCours,
    );
    _items.insert(0, e);
    return e;
  }
}

/// À brancher sur [DioServices] quand les endpoints sont disponibles.
class RemoteEncaissementRepository implements EncaissementRepository {
  @override
  Future<List<EncaissementEntry>> list() async {
    // TODO: GET …/encaissements (headers, auth) puis mapper le JSON → EncaissementEntry
    return [];
  }

  @override
  Future<EncaissementEntry> create({
    required String method,
    required String phone,
    String? extraNote,
  }) async {
    // TODO: POST …/encaissements
    throw UnimplementedError(
      'API encaissements : implémenter create() dans RemoteEncaissementRepository',
    );
  }
}
