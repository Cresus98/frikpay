/// Représentation locale d’une carte (l’id est géré côté app, pas saisi par l’utilisateur).
class CardItem {
  const CardItem({
    required this.id,
    required this.maskedPan,
    required this.last4,
    required this.phone,
    this.label = '',
    this.isActive = true,
  });

  final String id;
  final String maskedPan;
  final String last4;
  final String phone;
  final String label;
  final bool isActive;
}
