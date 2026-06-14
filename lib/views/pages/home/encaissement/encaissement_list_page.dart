import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/data/mock/models.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/providers/mock_providers.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/views/pages/home/encaissement/encaissement_wait_overlay.dart';
import 'package:fripay/views/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EncaissementListPage extends ConsumerWidget {
  const EncaissementListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final list = ref.watch(encaissementsProvider);
    final dev = ref.watch(selectedDevAccountProvider);
    final scheme = Theme.of(context).colorScheme;
    final money = NumberFormat('#,###', 'fr_FR');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.encaisser),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (dev == null) {
            _needDev(context);
            return;
          }
          context.pushNamed(RoutesNames.EncaissementForm);
        },
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.home4 == 'Cartes' ? 'Nouvel encaissement' : 'Ajouter'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (dev == null)
            MaterialBanner(
              content: const Text(
                'Sélectionnez un compte développeur dans Profil → Dev pour lancer un encaissement.',
              ),
              leading: Icon(Icons.warning_amber_rounded, color: scheme.secondary),
              actions: [
                TextButton(
                  onPressed: () =>
                      context.pushNamed(RoutesNames.DevAccounts),
                  child: const Text('Choisir un compte'),
                ),
              ],
            ),
          Expanded(
            child: list.isEmpty
                ? Center(
                    child: Text(
                      'Aucun encaissement.\nUtilisez le bouton + pour en ajouter.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.6)),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final e = list[i];
                      return _EncTile(entry: e, money: money, scheme: scheme);
                    },
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
        title: const Text('Compte développeur requis'),
        content: const Text(
          'Choisissez d’abord un compte Dev dans Profil afin d’identifier l’application.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ctx.pushNamed(RoutesNames.DevAccounts);
            },
            child: const Text('Ouvrir Dev'),
          ),
        ],
      ),
    );
  }
}

class _EncTile extends ConsumerWidget {
  const _EncTile({
    required this.entry,
    required this.money,
    required this.scheme,
  });

  final EncaissementEntry entry;
  final NumberFormat money;
  final ColorScheme scheme;

  bool _canRelaunch() {
    return entry.status == 'echec' || entry.status == 'en_attente';
  }

  Color _statusColor() {
    switch (entry.status) {
      case 'termine':
        return const Color(0xFF059669);
      case 'echec':
        return scheme.error;
      case 'en_cours':
        return scheme.primary;
      default:
        return scheme.outline;
    }
  }

  String _statusLabel() {
    switch (entry.status) {
      case 'termine':
        return 'Terminé';
      case 'echec':
        return 'Échec';
      case 'en_cours':
        return 'En cours';
      default:
        return 'En attente';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            title: Text(
              '${money.format(entry.amountFcfa)} FCFA · ${entry.method}',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              '${entry.phone}\n${DateFormat('dd/MM/y HH:mm', 'fr_FR').format(entry.createdAt)}',
              style: TextStyle(
                fontSize: 12,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            isThreeLine: true,
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  entry.id,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface.withValues(alpha: 0.45),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor().withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                  ),
                  child: Text(
                    _statusLabel(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _statusColor(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_canRelaunch())
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () async {
                    await runEncaissementProcessingDialog(
                      context: context,
                      ref: ref,
                      encId: entry.id,
                      setEnCoursFirst: true,
                    );
                    if (!context.mounted) return;
                    var st = '';
                    for (final x in ref.read(encaissementsProvider)) {
                      if (x.id == entry.id) st = x.status;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          st == 'termine'
                              ? 'Encaissement finalisé (mock).'
                              : 'Encore un échec simulé — vous pouvez réessayer.',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 20),
                  label: const Text('Relancer'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
