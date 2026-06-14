import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/data/mock/mock_repository.dart';
import 'package:fripay/providers/mock_providers.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class DevAccountsPage extends ConsumerWidget {
  const DevAccountsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = MockRepository.instance;
    final current = ref.watch(selectedDevAccountProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text('Comptes développeurs'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Sélectionnez le compte avec lequel les encaissements, paiements et cartes '
            'sont identifiés côté API (mock).',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.7),
                ),
          ),
          const SizedBox(height: 16),
          ...repo.devAccounts.map(
            (d) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  side: BorderSide(
                    color: current?.id == d.id
                        ? scheme.primary
                        : scheme.outlineVariant,
                    width: current?.id == d.id ? 2 : 1,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  onTap: () {
                    ref.read(selectedDevAccountProvider.notifier).select(d);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Compte actif : ${d.name}')),
                    );
                    context.pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: scheme.primary.withValues(alpha: 0.12),
                          child: Icon(Icons.code_rounded, color: scheme.primary),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                d.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${d.id} · ${d.environment}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      scheme.onSurface.withValues(alpha: 0.55),
                                ),
                              ),
                              Text(
                                'Préfixe clé : ${d.clientKeyPrefix}',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  color:
                                      scheme.onSurface.withValues(alpha: 0.45),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (current?.id == d.id)
                          Icon(Icons.check_circle_rounded,
                              color: scheme.primary),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (current != null) ...[
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                ref.read(selectedDevAccountProvider.notifier).clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mémorisation effacée. Choisissez un compte.'),
                  ),
                );
              },
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Effacer la sélection mémorisée'),
            ),
          ],
        ],
      ),
    );
  }
}
