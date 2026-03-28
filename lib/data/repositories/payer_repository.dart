import 'package:fripay/config/app_config.dart';
import 'package:fripay/controllers/init.dart';
import 'package:fripay/models/payment_record.dart';
import 'package:fripay/views/utils/constantes.dart';

/// Données agrégées écran Payer.
class PayerDashboard {
  const PayerDashboard({
    required this.appKey,
    required this.solde,
    required this.soldeDisponible,
    required this.payments,
  });

  final String appKey;
  final double solde;
  final double soldeDisponible;
  final List<PaymentRecord> payments;
}

abstract class PayerRepository {
  Future<PayerDashboard> load();

  Future<PaymentRecord> createPayment({
    required String method,
    required String phone,
    required double amount,
  });

  static PayerRepository createDefault() {
    return AppConfig.useMockBackend ? MockPayerRepository() : RemotePayerRepository();
  }
}

class MockPayerRepository implements PayerRepository {
  double _solde = 125_430.50;
  double _soldeDisponible = 98_200.00;
  final List<PaymentRecord> _payments = [
    PaymentRecord(
      id: 'pay-1',
      method: 'Moov Money',
      phone: '+229 90 11 22 33',
      amount: 5000,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  String _keyOrStored() {
    final stored = interne_storage.read(activeAppPaymentKey);
    if (stored is String && stored.isNotEmpty) return stored;
    final t = DateTime.now().millisecondsSinceEpoch.toString();
    final k = 'FK-${t.substring(t.length - 10)}';
    interne_storage.write(activeAppPaymentKey, k);
    return k;
  }

  @override
  Future<PayerDashboard> load() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return PayerDashboard(
      appKey: _keyOrStored(),
      solde: _solde,
      soldeDisponible: _soldeDisponible,
      payments: List<PaymentRecord>.from(_payments),
    );
  }

  @override
  Future<PaymentRecord> createPayment({
    required String method,
    required String phone,
    required double amount,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final p = PaymentRecord(
      id: 'pay-${DateTime.now().millisecondsSinceEpoch}',
      method: method,
      phone: phone,
      amount: amount,
      date: DateTime.now(),
    );
    _payments.insert(0, p);
    _soldeDisponible = (_soldeDisponible - amount).clamp(0, double.infinity);
    return p;
  }
}

class RemotePayerRepository implements PayerRepository {
  @override
  Future<PayerDashboard> load() async {
    // TODO: GET soldes + liste paiements + clé app
    final stored = interne_storage.read(activeAppPaymentKey);
    final key = stored is String && stored.isNotEmpty
        ? stored
        : 'FK-pending-api';
    return PayerDashboard(
      appKey: key,
      solde: 0,
      soldeDisponible: 0,
      payments: const [],
    );
  }

  @override
  Future<PaymentRecord> createPayment({
    required String method,
    required String phone,
    required double amount,
  }) async {
    throw UnimplementedError('API paiements : implémenter createPayment()');
  }
}
