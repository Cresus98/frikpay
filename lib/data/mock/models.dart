/// Modèles alignés sur la future API (données mock pour l’instant).

class DevAccount {
  const DevAccount({
    required this.id,
    required this.name,
    required this.environment,
    required this.clientKeyPrefix,
  });

  final String id;
  final String name;
  final String environment;
  /// Préfixe utilisé pour générart la clé de paiement « application ».
  final String clientKeyPrefix;
}

class EncaissementEntry {
  EncaissementEntry({
    required this.id,
    required this.method,
    required this.phone,
    required this.amountFcfa,
    required this.status,
    required this.createdAt,
    this.note,
  });

  final String id;
  final String method;
  final String phone;
  final int amountFcfa;
  /// en_attente | en_cours | termine | echec
  final String status;
  final DateTime createdAt;
  final String? note;
}

class PaymentEntry {
  PaymentEntry({
    required this.id,
    required this.method,
    required this.phone,
    required this.amountFcfa,
    required this.status,
    required this.at,
  });

  final String id;
  final String method;
  final String phone;
  final int amountFcfa;
  final String status;
  final DateTime at;
}

class WalletCard {
  WalletCard({
    required this.id,
    required this.last4,
    required this.typeId,
    required this.typeLabel,
    required this.phone,
    required this.balanceFcfa,
    required this.availableFcfa,
    required this.active,
  });

  final String id;
  final String last4;
  final String typeId;
  final String typeLabel;
  final String phone;
  final double balanceFcfa;
  final double availableFcfa;
  final bool active;

  String get masked => '•••• •••• •••• $last4';
}

class CardTypeOption {
  const CardTypeOption({
    required this.id,
    required this.label,
    required this.issueFeeFcfa,
  });

  final String id;
  final String label;
  final int issueFeeFcfa;
}
