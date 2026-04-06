import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/providers/mock_providers.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/views/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PayerHubPage extends ConsumerStatefulWidget {
  const PayerHubPage({super.key});

  @override
  ConsumerState<PayerHubPage> createState() => _PayerHubPageState();
}

class _PayerHubPageState extends ConsumerState<PayerHubPage> {
  /// Soldes mock (à brancher sur l’API).
  static const double _soldeFcfa = 1250000;
  static const double _soldeDispoFcfa = 1180450;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final dev = ref.watch(selectedDevAccountProvider);
    final key = ref.watch(appPaymentKeyProvider);
    final payments = ref.watch(paymentsProvider);
    final money = NumberFormat('#,###', 'fr_FR');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.payer),
        actions: [
          IconButton(
            tooltip: 'Rafraîchir la clé',
            icon: const Icon(Icons.key_rounded),
            onPressed: dev == null
                ? null
                : () {
                    refreshAppPaymentKey(ref);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Clé de paiement régénérée.')),
                    );
                  },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: dev == null
            ? () => _needDev(context)
            : () => context.pushNamed(RoutesNames.PayerForm),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nouveau paiement'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
        children: [
          if (dev == null)
            Card(
              color: scheme.secondary.withValues(alpha: 0.12),
              child: ListTile(
                leading: Icon(Icons.developer_mode_rounded, color: scheme.secondary),
                title: const Text('Compte développeur requis'),
                subtitle: const Text(
                  'La clé de paiement est générée pour le compte Dev actif.',
                ),
                trailing: TextButton(
                  onPressed: () => context.pushNamed(RoutesNames.DevAccounts),
                  child: const Text('Choisir'),
                ),
              ),
            )
          else
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.vpn_key_rounded, color: scheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Clé application (paiement)',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SelectableText(
                      key ?? '—',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        color: scheme.onSurface,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: key == null
                            ? null
                            : () async {
                                await Clipboard.setData(ClipboardData(text: key));
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Clé copiée')),
                                  );
                                }
                              },
                        icon: const Icon(Icons.copy_rounded, size: 18),
                        label: const Text('Copier'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _BalanceMini(
                  title: 'Solde',
                  amount: money.format(_soldeFcfa.toInt()),
                  scheme: scheme,
                  icon: Icons.account_balance_wallet_outlined,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _BalanceMini(
                  title: 'Solde disponible',
                  amount: money.format(_soldeDispoFcfa.toInt()),
                  scheme: scheme,
                  icon: Icons.savings_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Paiements',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          if (payments.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  'Aucun paiement pour l’instant.',
                  style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.55)),
                ),
              ),
            )
          else
            ...payments.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    side: BorderSide(color: scheme.outlineVariant),
                  ),
                  tileColor: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
                  leading: CircleAvatar(
                    backgroundColor: scheme.primary.withValues(alpha: 0.12),
                    child: Icon(Icons.north_east_rounded, color: scheme.primary),
                  ),
                  title: Text(
                    '${money.format(p.amountFcfa)} FCFA',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  isThreeLine: true,
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        p.method,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        p.phone,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: scheme.onSurface.withValues(alpha: 0.65),
                              height: 1.25,
                              letterSpacing: 0.2,
                            ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    DateFormat.Md().add_Hm().format(p.at),
                    style: TextStyle(
                      fontSize: 11,
                      color: scheme.onSurface.withValues(alpha: 0.45),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _needDev(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Compte Dev'),
        content: const Text(
          'Sélectionnez un compte développeur dans Profil pour activer la clé de paiement.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.pushNamed(RoutesNames.DevAccounts);
            },
            child: const Text('Ouvrir'),
          ),
        ],
      ),
    );
  }
}

class _BalanceMini extends StatelessWidget {
  const _BalanceMini({
    required this.title,
    required this.amount,
    required this.scheme,
    required this.icon,
  });

  final String title;
  final String amount;
  final ColorScheme scheme;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 22, color: scheme.primary),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            Text(
              '$amount FCFA',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
