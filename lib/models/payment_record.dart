class PaymentRecord {
  const PaymentRecord({
    required this.id,
    required this.method,
    required this.phone,
    required this.amount,
    required this.date,
  });

  final String id;
  final String method;
  final String phone;
  final double amount;
  final DateTime date;
}
