import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/controllers/card_controller.dart';
import 'package:fripay/controllers/dev_account_controller.dart';
import 'package:fripay/models/card/card_model.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:intl/intl.dart';

Future<void> showCardDetailsSheet(BuildContext context, CardInfo c) {
  final money = NumberFormat('#,###', 'fr_FR');
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (ctx) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      minChildSize: 0.35,
      maxChildSize: 0.92,
      builder: (_, sc) => ListView(
        controller: sc,
        padding: const EdgeInsets.all(20),
        children: [
          Text('Détails carte', style: Theme.of(ctx).textTheme.titleLarge),
          const Divider(height: 28),
          _DetailRow(label: 'Identifiant interne', value: c.accountId),
          _DetailRow(label: 'PAN Masqué', value: c.accountId),
          _DetailRow(label: 'ID de la carte', value: c.accountId),
          _DetailRow(label: 'Téléphone', value: c.phone),
          _DetailRow(label: 'Statut', value: (c.statusCarte == 'active' || c.statusCarte == '1') ? 'Active' : 'Désactivée'),
        ],
      ),
    ),
  );
}

// removed _kv

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        SizedBox(width: 150, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
      ]));
}

Future<void> showRechargeSheet(
    BuildContext context, WidgetRef ref, CardInfo c) async {
  final amount = TextEditingController();
  final last4 = TextEditingController();
  final phone = TextEditingController(text: c.phone);
  final formKey = GlobalKey<FormState>();

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.viewInsetsOf(ctx).bottom + 20,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Recharger', style: Theme.of(ctx).textTheme.titleMedium),
            Text('Carte ${c.accountId}',
                style: Theme.of(ctx).textTheme.bodySmall),
            const SizedBox(height: 12),
            TextFormField(
              enabled: false,
              initialValue: c.accountId,
              decoration: const InputDecoration(labelText: 'ID carte'),
            ),
            TextFormField(
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Montant FCFA'),
              validator: (v) =>
                  (v == null || int.tryParse(v) == null) ? 'Invalide' : null,
            ),
            TextFormField(
              controller: last4,
              decoration:
                  const InputDecoration(labelText: '4 derniers chiffres'),
              maxLength: 4,
              validator: (v) => (v == null || v.length != 4) ? '4 chiffres' : null,
            ),
            TextFormField(
              controller: phone,
              decoration: const InputDecoration(labelText: 'Téléphone'),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                if (!(formKey.currentState?.validate() ?? false)) return;
                FocusManager.instance.primaryFocus?.unfocus();
                
                final devAccounts = ref.read(devAccountControllerProvider).accounts;
                final appKey = devAccounts.isNotEmpty ? devAccounts.first.token : "";
                
                final success = await ref.read(cardControllerProvider.notifier).loadCard(
                  carteId: c.accountId,
                  amount: amount.text,
                  last4Digits: last4.text,
                  phone: phone.text,
                  appKey: appKey,
                );
                
                if (!context.mounted) return;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(success ? 'Recharge effectuée avec succès.' : 'Échec de la recharge.')),
                );
              },
              child: const Text('Valider'),
            ),
          ],
        ),
      ),
    ),
  );

  amount.dispose();
  last4.dispose();
  phone.dispose();
}

Future<void> showToggleActiveSheet(
  BuildContext context,
  WidgetRef ref,
  CardInfo c,
  bool activate,
) async {
  final last4 = TextEditingController();
  final phone = TextEditingController(text: c.phone);
  final formKey = GlobalKey<FormState>();

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.viewInsetsOf(ctx).bottom + 20,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(activate ? 'Activer la carte' : 'Désactiver la carte',
                style: Theme.of(ctx).textTheme.titleMedium),
            Text('ID: ${c.accountId}', style: Theme.of(ctx).textTheme.bodySmall),
            const SizedBox(height: 12),
            TextFormField(
              controller: last4,
              decoration:
                  const InputDecoration(labelText: '4 derniers chiffres'),
              maxLength: 4,
              validator: (v) => (v == null || v.length != 4) ? 'Requis' : null,
            ),
            TextFormField(
              controller: phone,
              decoration: const InputDecoration(labelText: 'Téléphone associé'),
              validator: (v) =>
                  (v == null || v.trim().length < 8) ? 'Requis' : null,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                if (!(formKey.currentState?.validate() ?? false)) return;
                FocusManager.instance.primaryFocus?.unfocus();
                
                final devAccounts = ref.read(devAccountControllerProvider).accounts;
                final appKey = devAccounts.isNotEmpty ? devAccounts.first.token : "";
                
                bool success = false;
                if (activate) {
                  success = await ref.read(cardControllerProvider.notifier).activateCard(carteId: c.accountId, appKey: appKey);
                } else {
                  success = await ref.read(cardControllerProvider.notifier).deactivateCard(carteId: c.accountId, appKey: appKey);
                }

                if (!context.mounted) return;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success ? (activate ? 'Carte activée.' : 'Carte désactivée.') : 'Erreur lors de l\'opération.',
                    ),
                  ),
                );
              },
              child: const Text('Confirmer'),
            ),
          ],
        ),
      ),
    ),
  );

  last4.dispose();
  phone.dispose();
}

Future<void> showWithdrawSheet(
    BuildContext context, WidgetRef ref, CardInfo c) async {
  final amount = TextEditingController();
  final last4 = TextEditingController();
  final phone = TextEditingController(text: c.phone);
  final otp = TextEditingController();
  final step = ValueNotifier<int>(0);
  final formKey = GlobalKey<FormState>();

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => ValueListenableBuilder<int>(
      valueListenable: step,
      builder: (ctx, st, _) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: MediaQuery.viewInsetsOf(ctx).bottom + 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Retrait sur carte',
                  style: Theme.of(ctx).textTheme.titleMedium),
              if (st == 0) ...[
                TextFormField(
                  enabled: false,
                  initialValue: c.accountId,
                  decoration: const InputDecoration(labelText: 'ID carte'),
                ),
                TextFormField(
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Montant FCFA'),
                  validator: (v) =>
                      (v == null || int.tryParse(v) == null) ? 'Invalide' : null,
                ),
                TextFormField(
                  controller: last4,
                  decoration:
                      const InputDecoration(labelText: '4 derniers chiffres'),
                  maxLength: 4,
                  validator: (v) => (v == null || v.length != 4) ? 'Requis' : null,
                ),
                TextFormField(
                  controller: phone,
                  decoration: const InputDecoration(labelText: 'Téléphone'),
                  validator: (v) =>
                      (v == null || v.trim().length < 8) ? 'Requis' : null,
                ),
                FilledButton(
                  onPressed: () async {
                    if (!(formKey.currentState?.validate() ?? false)) return;
                    final devAccounts = ref.read(devAccountControllerProvider).accounts;
                    final appKey = devAccounts.isNotEmpty ? devAccounts.first.token : "";
                    
                    final withdrawalId = await ref.read(cardControllerProvider.notifier).withdrawalInit(
                      carteId: c.accountId,
                      amount: amount.text,
                      last4Digits: last4.text,
                      phone: phone.text,
                      appKey: appKey,
                    );
                    if (withdrawalId != null) {
                      step.value = 1;
                    } else {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        const SnackBar(content: Text('Erreur lors de l\'initiation du retrait.')),
                      );
                    }
                  },
                  child: const Text('Demander OTP'),
                ),
              ] else ...[
                Text(
                  'OTP démo : 482916',
                  style: Theme.of(ctx).textTheme.bodyMedium,
                ),
                TextFormField(
                  controller: otp,
                  decoration: const InputDecoration(labelText: 'Code OTP'),
                  keyboardType: TextInputType.number,
                ),
                FilledButton(
                  onPressed: () async {
                    if (otp.text.isEmpty) return;
                    final devAccounts = ref.read(devAccountControllerProvider).accounts;
                    final appKey = devAccounts.isNotEmpty ? devAccounts.first.token : "";
                    final withdrawalId = ref.read(cardControllerProvider).pendingWithdrawalId;
                    
                    final success = await ref.read(cardControllerProvider.notifier).withdrawalValidate(
                      withdrawalId: withdrawalId,
                      code: otp.text,
                      appKey: appKey,
                    );
                    
                    if (!context.mounted) return;
                    if (!success) {
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        const SnackBar(content: Text('OTP incorrect ou erreur réseau.')),
                      );
                      return;
                    }
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Retrait finalisé avec succès.')),
                    );
                  },
                  child: const Text('Finaliser'),
                ),
              ],
            ],
          ),
        ),
      ),
    ),
  );

  step.dispose();
  amount.dispose();
  last4.dispose();
  phone.dispose();
  otp.dispose();
}

Future<void> showTransferSheet(
    BuildContext context, WidgetRef ref, CardInfo from, List<CardInfo> all) async {
  final others = all.where((e) => e.accountId != from.accountId).toList();
  if (others.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Aucune autre carte pour le transfert.')),
    );
    return;
  }

  final amount = TextEditingController();
  final last4 = TextEditingController();
  var toId = others.first.accountId;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setSt) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: MediaQuery.viewInsetsOf(ctx).bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Transfert carte à carte',
                style: Theme.of(ctx).textTheme.titleMedium),
            Text('Depuis ${from.accountId}', style: Theme.of(ctx).textTheme.bodySmall),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey<String>(toId),
              initialValue: toId,
              decoration: const InputDecoration(labelText: 'Vers carte'),
              items: [
                for (final o in others)
                  DropdownMenuItem(
                    value: o.accountId,
                    child: Text('${o.accountId}'),
                  ),
              ],
              onChanged: (v) {
                if (v != null) setSt(() => toId = v);
              },
            ),
            TextFormField(
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Montant FCFA'),
            ),
            TextFormField(
              controller: last4,
              decoration:
                  const InputDecoration(labelText: '4 derniers (carte source)'),
              maxLength: 4,
            ),
            FilledButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                
                final devAccounts = ref.read(devAccountControllerProvider).accounts;
                final appKey = devAccounts.isNotEmpty ? devAccounts.first.token : "";
                
                final transferId = await ref.read(cardControllerProvider.notifier).transferInit(
                  fromCarteId: from.accountId,
                  toCarteId: toId,
                  amount: amount.text,
                  last4Digits: last4.text,
                  appKey: appKey,
                );
                
                if (!context.mounted) return;
                Navigator.pop(ctx);
                
                if (transferId != null) {
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text('Transfert initié vers $toId.')),
                   );
                   // Idéalement afficher un champ pour entrer l'OTP de transfert ici
                } else {
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('Erreur lors du transfert.')),
                   );
                }
              },
              child: const Text('Transférer'),
            ),
          ],
        ),
      ),
    ),
  );

  amount.dispose();
  last4.dispose();
}

Future<void> showTransactionsSheet(BuildContext context, WidgetRef ref, CardInfo c) async {
  final q = TextEditingController();

  final devAccounts = ref.read(devAccountControllerProvider).accounts;
  final appKey = devAccounts.isNotEmpty ? devAccounts.first.token : "";
  final date = DateFormat('MM-yyyy').format(DateTime.now());

  // Show loading indicator before fetching
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  await ref.read(cardControllerProvider.notifier).fetchTransactions(
    carteId: c.accountId,
    date: date,
    appKey: appKey,
  );

  if (!context.mounted) return;
  Navigator.of(context).pop();

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => Consumer(
      builder: (ctx, ref, child) {
        final txs = ref.watch(cardControllerProvider).transactions;
        final filtered = txs
            .where((t) => (t.description ?? '').toLowerCase().contains(q.text.toLowerCase()) || 
                          (t.transactionId ?? '').toLowerCase().contains(q.text.toLowerCase()))
            .toList();
            
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(ctx).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  controller: q,
                  decoration: const InputDecoration(
                    hintText: 'Rechercher…',
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                  onChanged: (_) => (ctx as Element).markNeedsBuild(),
                ),
              ),
              SizedBox(
                height: 280,
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (_, i) => ListTile(
                    leading: const Icon(Icons.swap_horiz_rounded),
                    title: Text(filtered[i].description ?? 'Transaction'),
                    subtitle: Text('${filtered[i].transactionDate} - ${filtered[i].baseAmount} ${filtered[i].currency}'),
                    trailing: Text(filtered[i].status ?? ''),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  q.dispose();
}

Future<void> showLiveBalanceDialog(BuildContext context, WidgetRef ref, CardInfo c) async {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );
  
  final devAccounts = ref.read(devAccountControllerProvider).accounts;
  final appKey = devAccounts.isNotEmpty ? devAccounts.first.token : "";
  
  final bal = await ref.read(cardControllerProvider.notifier).fetchBalance(carteId: c.accountId, appKey: appKey);
  
  if (!context.mounted) return;
  Navigator.of(context).pop();
  
  final money = NumberFormat('#,###', 'fr_FR');
  final amount = bal != null ? money.format(int.tryParse(bal) ?? 0) : '0';
  
  showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Solde temps réel'),
      content: Text(
        '$amount FCFA\n(carte ${c.accountId}).',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
