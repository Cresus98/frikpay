import 'package:flutter/services.dart';

/// Validation date d'expiration carte au format saisi : **MM / AA** (4 chiffres).
abstract final class CardExpiry {
  CardExpiry._();

  static String digitsOnly(String? s) =>
      (s ?? '').replaceAll(RegExp(r'\D'), '');

  /// Fin de validité = dernier jour du mois d'expiration.
  static bool isExpired(int month, int year2digit) {
    final now = DateTime.now();
    final lastValidDay = DateTime(2000 + year2digit, month + 1, 0);
    final today = DateTime(now.year, now.month, now.day);
    return lastValidDay.isBefore(today);
  }

  /// Codes : `empty`, `incomplete`, `month`, `expired`, ou `null` si OK.
  static String? validateCode(String? value) {
    final d = digitsOnly(value);
    if (d.isEmpty) return 'empty';
    if (d.length < 4) return 'incomplete';
    final m = int.tryParse(d.substring(0, 2));
    final y = int.tryParse(d.substring(2, 4));
    if (m == null || y == null) return 'month';
    if (m < 1 || m > 12) return 'month';
    if (isExpired(m, y)) return 'expired';
    return null;
  }
}

/// Saisie guidée : jusqu'à 4 chiffres, affichage `MM / AA`.
class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 4) digits = digits.substring(0, 4);

    final String newText;
    if (digits.isEmpty) {
      newText = '';
    } else if (digits.length <= 2) {
      newText = digits;
    } else {
      newText = '${digits.substring(0, 2)} / ${digits.substring(2)}';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
