class EncaissementEntry {
  EncaissementEntry({
    required this.id,
    required this.method,
    required this.phone,
    required this.createdAt,
    this.status = EncaissementStatus.enAttente,
  });

  final String id;
  final String method;
  final String phone;
  final DateTime createdAt;
  EncaissementStatus status;
}

enum EncaissementStatus { enAttente, enCours, termine, echec }
