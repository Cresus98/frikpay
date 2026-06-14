import 'package:flutter/material.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:intl/intl.dart';

class _MockOperation {
  const _MockOperation({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.credit,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final double amount;
  final bool credit;
  final IconData icon;
}

class AnimatedListPage extends StatelessWidget {
  AnimatedListPage({super.key});

  static const _ops = [
    _MockOperation(
      title: 'Encaissement Moov',
      subtitle: '28 mars 2026 · Réf. MOCK-001',
      amount: 12500,
      credit: true,
      icon: Icons.south_west_rounded,
    ),
    _MockOperation(
      title: 'Paiement MTN',
      subtitle: '27 mars 2026 · Réf. MOCK-002',
      amount: 3200,
      credit: false,
      icon: Icons.north_east_rounded,
    ),
    _MockOperation(
      title: 'Recharge compte',
      subtitle: '26 mars 2026 · Carte ••4242',
      amount: 50000,
      credit: true,
      icon: Icons.account_balance_wallet_outlined,
    ),
    _MockOperation(
      title: 'Transfert sortant',
      subtitle: '25 mars 2026 · vers +229 97…',
      amount: 15000,
      credit: false,
      icon: Icons.swap_horiz_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final money = NumberFormat.currency(locale: 'fr_FR', symbol: '');

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.operations_title),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Icon(Icons.developer_mode_rounded, color: scheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Données de démonstration : même logique qu’avec l’API en production.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            height: 1.35,
                            color: scheme.onSurface.withValues(alpha: 0.75),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          ..._ops.map((item) {
            final amt = money.format(item.amount).trim();
            final sign = item.credit ? '+' : '−';
            final color =
                item.credit ? const Color(0xFF059669) : scheme.error;

            return Padding(
              key: ValueKey(item.title + item.subtitle),
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  side: BorderSide(color: scheme.outlineVariant),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  leading: CircleAvatar(
                    backgroundColor: scheme.primary.withValues(alpha: 0.12),
                    child: Icon(item.icon, color: scheme.primary, size: 22),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    item.subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: scheme.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                  trailing: Text(
                    '$sign $amt XOF',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: color,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
