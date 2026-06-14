import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/data/dev_account_storage.dart';
import 'package:fripay/data/mock/mock_repository.dart';
import 'package:fripay/data/mock/models.dart';

final appPaymentKeyProvider = StateProvider<String?>((ref) => null);

/// Compte Dev mémorisé (GetStorage) + clé de paiement associée.
class DevSelectionNotifier extends StateNotifier<DevAccount?> {
  DevSelectionNotifier(this._ref) : super(_readInitial()) {
    // Riverpod interdit de modifier un autre provider pendant la création de
    // celui-ci. On aligne la clé juste après le cycle d’init.
    Future<void>.microtask(() => _applyKeyForState(state));
  }

  final Ref _ref;

  static DevAccount? _readInitial() {
    final id = DevAccountStorage.readId();
    if (id == null) return null;
    for (final d in MockRepository.instance.devAccounts) {
      if (d.id == id) return d;
    }
    return null;
  }

  void _applyKeyForState(DevAccount? dev) {
    if (dev == null) {
      _ref.read(appPaymentKeyProvider.notifier).state = null;
    } else {
      _ref.read(appPaymentKeyProvider.notifier).state =
          MockRepository.instance.generateAppPaymentKey(dev);
    }
  }

  void select(DevAccount d) {
    state = d;
    DevAccountStorage.writeId(d.id);
    _applyKeyForState(d);
  }

  void clear() {
    state = null;
    DevAccountStorage.clear();
    _applyKeyForState(null);
  }

  /// Nouvelle clé pour le même compte (bouton rafraîchir).
  void regeneratePaymentKey() {
    _applyKeyForState(state);
  }
}

final selectedDevAccountProvider =
    StateNotifierProvider<DevSelectionNotifier, DevAccount?>((ref) {
  return DevSelectionNotifier(ref);
});

void refreshAppPaymentKey(WidgetRef ref) {
  ref.read(selectedDevAccountProvider.notifier).regeneratePaymentKey();
}

final encaissementsProvider =
    StateNotifierProvider<EncaissementsNotifier, List<EncaissementEntry>>(
  (ref) => EncaissementsNotifier(),
);

class EncaissementsNotifier extends StateNotifier<List<EncaissementEntry>> {
  EncaissementsNotifier()
      : super(List.from(MockRepository.instance.encaissements));

  void add(EncaissementEntry e) => state = [e, ...state];

  void updateStatus(String id, String status) {
    state = [
      for (final x in state)
        if (x.id == id)
          EncaissementEntry(
            id: x.id,
            method: x.method,
            phone: x.phone,
            amountFcfa: x.amountFcfa,
            status: status,
            createdAt: x.createdAt,
            note: x.note,
          )
        else
          x,
    ];
  }
}

final paymentsProvider =
    StateNotifierProvider<PaymentsNotifier, List<PaymentEntry>>(
  (ref) => PaymentsNotifier(),
);

class PaymentsNotifier extends StateNotifier<List<PaymentEntry>> {
  PaymentsNotifier() : super(List.from(MockRepository.instance.payments));

  void add(PaymentEntry e) => state = [e, ...state];
}

final walletCardsProvider =
    StateNotifierProvider<WalletCardsNotifier, List<WalletCard>>(
  (ref) => WalletCardsNotifier(),
);

class WalletCardsNotifier extends StateNotifier<List<WalletCard>> {
  WalletCardsNotifier() : super(List.from(MockRepository.instance.cards));

  void add(WalletCard c) => state = [...state, c];

  void updateCard(String id, WalletCard Function(WalletCard) fn) {
    state = [
      for (final x in state) if (x.id == id) fn(x) else x,
    ];
  }

  WalletCard? byId(String id) {
    try {
      return state.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}
