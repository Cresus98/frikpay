import 'dart:math';

import 'models.dart';

/// Données et logique « API » simulées.
final class MockRepository {
  MockRepository._();
  static final MockRepository instance = MockRepository._();

  static final _rnd = Random();

  final List<DevAccount> devAccounts = [
    const DevAccount(
      id: 'DEV-001',
      name: 'FinanfaSend – Recette',
      environment: 'RECETTE',
      clientKeyPrefix: 'FIN',
    ),
    const DevAccount(
      id: 'DEV-002',
      name: 'Partenaire Sandbox',
      environment: 'SANDBOX',
      clientKeyPrefix: 'SBX',
    ),
    const DevAccount(
      id: 'DEV-003',
      name: 'Marchand pilote',
      environment: 'PILOTE',
      clientKeyPrefix: 'MRC',
    ),
  ];

  final List<EncaissementEntry> encaissements = [
    EncaissementEntry(
      id: 'ENC-1001',
      method: 'Moov Money',
      phone: '+229 97 00 00 01',
      amountFcfa: 25000,
      status: 'termine',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    EncaissementEntry(
      id: 'ENC-1002',
      method: 'MTN Mobile Money',
      phone: '+229 96 11 22 33',
      amountFcfa: 15000,
      status: 'en_attente',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];

  final List<PaymentEntry> payments = [
    PaymentEntry(
      id: 'PAY-2001',
      method: 'Moov Money',
      phone: '+229 97 44 55 66',
      amountFcfa: 5000,
      status: 'termine',
      at: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  final List<WalletCard> cards = [
    WalletCard(
      id: 'CRT-A7F2',
      last4: '4242',
      typeId: 'STD',
      typeLabel: 'Carte standard',
      phone: '+229 97 00 11 22',
      balanceFcfa: 150750,
      availableFcfa: 148200,
      active: true,
    ),
    WalletCard(
      id: 'CRT-B91C',
      last4: '8891',
      typeId: 'PRE',
      typeLabel: 'Carte premium',
      phone: '+229 96 33 44 55',
      balanceFcfa: 52000,
      availableFcfa: 52000,
      active: false,
    ),
  ];

  String generateAppPaymentKey(DevAccount dev) {
    final t = DateTime.now().millisecondsSinceEpoch.toRadixString(36).toUpperCase();
    return 'PAY-${dev.clientKeyPrefix}-$t';
  }

  Future<List<CardTypeOption>> fetchCardTypes() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return const [
      CardTypeOption(id: 'STD', label: 'Standard', issueFeeFcfa: 2500),
      CardTypeOption(id: 'PRE', label: 'Premium', issueFeeFcfa: 5000),
      CardTypeOption(id: 'ENT', label: 'Entreprise', issueFeeFcfa: 10000),
    ];
  }

  String nextEncId() =>
      'ENC-${1000 + encaissements.length + _rnd.nextInt(99)}';

  String nextPayId() =>
      'PAY-${2000 + payments.length + _rnd.nextInt(99)}';

  String nextCardId() =>
      'CRT-${_rnd.nextInt(9)}${_rnd.nextInt(9)}${_rnd.nextInt(9)}${_rnd.nextInt(9)}';

  /// Solde « temps réel » simulé après appel.
  Future<double> fetchCardBalance(String cardId) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    WalletCard? found;
    for (final c in cards) {
      if (c.id == cardId) {
        found = c;
        break;
      }
    }
    if (found == null) return 0;
    return found.balanceFcfa + _rnd.nextInt(500) - 250;
  }

  /// Garde la liste mock alignée avec les cartes ajoutées dans l’app (solde simulé).
  void registerMockCard(WalletCard c) {
    cards.add(c);
  }

  /// ~72 % de réussite après la file d’attente — pour tester la relance depuis la liste.
  bool randomEncaissementOutcome() => _rnd.nextDouble() < 0.72;
}
