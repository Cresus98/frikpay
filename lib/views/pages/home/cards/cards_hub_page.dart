import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/data/mock/models.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/providers/mock_providers.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/views/pages/home/cards/card_actions.dart';
import 'package:fripay/views/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CardsHubPage extends ConsumerWidget {
  const CardsHubPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final cards = ref.watch(walletCardsProvider);
    final money = NumberFormat('#,###', 'fr_FR');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.cards_title),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(RoutesNames.Home1),
        icon: const Icon(Icons.add_card_rounded),
        label: Text(l10n.add_card),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
            child: Row(
              children: [
                Icon(Icons.verified_user_outlined,
                    size: 22, color: scheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.cards_subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurface.withValues(alpha: 0.7),
                        ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: cards.isEmpty
                ? Center(
                    child: Text(
                      'Aucune carte.\nAppuyez sur + pour en ajouter une.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: scheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                    itemCount: cards.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final c = cards[i];
                      return _CardRow(
                        card: c,
                        money: money,
                        scheme: scheme,
                        allCards: cards,
                        ref: ref,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _CardRow extends StatelessWidget {
  const _CardRow({
    required this.card,
    required this.money,
    required this.scheme,
    required this.allCards,
    required this.ref,
  });

  final WalletCard card;
  final NumberFormat money;
  final ColorScheme scheme;
  final List<WalletCard> allCards;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final c = card;
    return Material(
      color: scheme.surfaceContainerHighest.withValues(alpha: 0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        onTap: () => showCardDetailsSheet(context, c),
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: scheme.primary.withValues(alpha: 0.12),
                child: Icon(
                  Icons.credit_card_rounded,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${c.typeLabel} · ${c.masked}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${money.format(c.balanceFcfa.toInt())} FCFA · '
                      '${c.active ? 'Active' : 'Désactivée'}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                scheme.onSurface.withValues(alpha: 0.65),
                          ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Actions',
                style: IconButton.styleFrom(
                  foregroundColor: scheme.onSurface.withValues(alpha: 0.55),
                ),
                onPressed: () =>
                    _showCardActionsSheet(context, ref, c, allCards),
                icon: const Icon(Icons.more_horiz_rounded, size: 26),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showCardActionsSheet(
  BuildContext context,
  WidgetRef ref,
  WalletCard c,
  List<WalletCard> allCards,
) async {
  final scheme = Theme.of(context).colorScheme;
  final money = NumberFormat('#,###', 'fr_FR');
  final rootNav = Navigator.of(context);

  void closeThen(Future<void> Function() fn) {
    rootNav.pop();
    Future.microtask(() async => fn());
  }

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (sheetCtx) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: MediaQuery.viewInsetsOf(sheetCtx).bottom + 8,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(sheetCtx).height * 0.78,
            ),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: scheme.outlineVariant.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: scheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: Icon(Icons.credit_card_rounded,
                            color: scheme.primary, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c.typeLabel,
                              style: Theme.of(sheetCtx).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              c.masked,
                              style: Theme.of(sheetCtx).textTheme.bodySmall?.copyWith(
                                    fontFamily: 'monospace',
                                    letterSpacing: 0.3,
                                    color: scheme.onSurface.withValues(alpha: 0.65),
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: [
                                _SheetChip(
                                  icon: Icons.payments_outlined,
                                  label:
                                      '${money.format(c.balanceFcfa.toInt())} FCFA',
                                  scheme: scheme,
                                ),
                                _SheetChip(
                                  icon: c.active
                                      ? Icons.check_circle_outline_rounded
                                      : Icons.pause_circle_outline_rounded,
                                  label: c.active ? 'Active' : 'Désactivée',
                                  scheme: scheme,
                                  muted: !c.active,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => rootNav.pop(),
                        icon: Icon(Icons.close_rounded,
                            color: scheme.onSurface.withValues(alpha: 0.45)),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: scheme.outlineVariant.withValues(alpha: 0.5),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _SheetSectionLabel(
                          scheme: scheme,
                          label: 'Consulter',
                        ),
                        _SheetActionRow(
                          icon: Icons.info_outline_rounded,
                          title: 'Détails',
                          subtitle: 'Informations complètes de la carte',
                          scheme: scheme,
                          onTap: () => closeThen(
                              () => showCardDetailsSheet(context, c)),
                        ),
                        _SheetActionRow(
                          icon: Icons.account_balance_wallet_outlined,
                          title: 'Solde temps réel',
                          subtitle: 'Interrogation simulée du solde',
                          scheme: scheme,
                          onTap: () => closeThen(
                              () => showLiveBalanceDialog(context, c)),
                        ),
                        _SheetActionRow(
                          icon: Icons.receipt_long_outlined,
                          title: 'Transactions',
                          subtitle: 'Historique et recherche (mock)',
                          scheme: scheme,
                          onTap: () => closeThen(
                              () => showTransactionsSheet(context, c)),
                        ),
                        const SizedBox(height: 6),
                        _SheetSectionLabel(
                          scheme: scheme,
                          label: 'Opérations',
                        ),
                        _SheetActionRow(
                          icon: Icons.add_card_outlined,
                          title: 'Recharger',
                          scheme: scheme,
                          onTap: () => closeThen(
                              () => showRechargeSheet(context, ref, c)),
                        ),
                        _SheetActionRow(
                          icon: Icons.arrow_circle_down_outlined,
                          title: 'Retrait',
                          scheme: scheme,
                          onTap: () => closeThen(
                              () => showWithdrawSheet(context, ref, c)),
                        ),
                        _SheetActionRow(
                          icon: Icons.swap_horiz_rounded,
                          title: 'Transfert carte à carte',
                          scheme: scheme,
                          onTap: () => closeThen(
                              () => showTransferSheet(context, c, allCards)),
                        ),
                        const SizedBox(height: 6),
                        _SheetSectionLabel(
                          scheme: scheme,
                          label: 'Statut',
                        ),
                        if (c.active)
                          _SheetActionRow(
                            icon: Icons.toggle_off_outlined,
                            title: 'Désactiver la carte',
                            subtitle: 'Blocage temporaire',
                            scheme: scheme,
                            onTap: () => closeThen(() =>
                                showToggleActiveSheet(context, ref, c, false)),
                          ),
                        if (!c.active)
                          _SheetActionRow(
                            icon: Icons.toggle_on_outlined,
                            title: 'Activer la carte',
                            scheme: scheme,
                            onTap: () => closeThen(() =>
                                showToggleActiveSheet(context, ref, c, true)),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _SheetChip extends StatelessWidget {
  const _SheetChip({
    required this.icon,
    required this.label,
    required this.scheme,
    this.muted = false,
  });

  final IconData icon;
  final String label;
  final ColorScheme scheme;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final fg = muted
        ? scheme.onSurface.withValues(alpha: 0.5)
        : scheme.onSurface.withValues(alpha: 0.78);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: fg),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetSectionLabel extends StatelessWidget {
  const _SheetSectionLabel({
    required this.scheme,
    required this.label,
  });

  final ColorScheme scheme;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.9,
          color: scheme.primary.withValues(alpha: 0.85),
        ),
      ),
    );
  }
}

class _SheetActionRow extends StatelessWidget {
  const _SheetActionRow({
    required this.icon,
    required this.title,
    required this.scheme,
    required this.onTap,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final ColorScheme scheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(AppRadius.md),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(icon, color: scheme.primary, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: scheme.onSurface.withValues(alpha: 0.58),
                                height: 1.25,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: scheme.onSurface.withValues(alpha: 0.35),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
