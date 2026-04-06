import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/data/mock/mock_repository.dart';
import 'package:fripay/data/mock/models.dart';
import 'package:fripay/providers/mock_providers.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:intl/intl.dart';

Future<void> showCardDetailsSheet(BuildContext context, WalletCard c) {
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
          _kv('Identifiant interne', c.id),
          _kv('Numéro masqué', c.masked),
          _kv('Type', c.typeLabel),
          _kv('Téléphone lié', c.phone),
          _kv('Statut', c.active ? 'Active' : 'Désactivée'),
          _kv('Solde (données locale)', '${money.format(c.balanceFcfa.toInt())} FCFA'),
          _kv('Disponible', '${money.format(c.availableFcfa.toInt())} FCFA'),
        ],
      ),
    ),
  );
}

Widget _kv(String k, String v) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(k,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
          Expanded(child: Text(v, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );

Future<void> showRechargeSheet(
    BuildContext context, WidgetRef ref, WalletCard c) async {
  final amount = TextEditingController();
  final last4 = TextEditingController(text: c.last4);
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
            Text('Carte ${c.id}',
                style: Theme.of(ctx).textTheme.bodySmall),
            const SizedBox(height: 12),
            TextFormField(
              enabled: false,
              initialValue: c.id,
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
              onPressed: () {
                if (!(formKey.currentState?.validate() ?? false)) return;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Recharge simulée — brancher l’API.')),
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
  WalletCard c,
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
            Text('ID: ${c.id}', style: Theme.of(ctx).textTheme.bodySmall),
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
              onPressed: () {
                if (!(formKey.currentState?.validate() ?? false)) return;
                ref.read(walletCardsProvider.notifier).updateCard(
                      c.id,
                      (x) => WalletCard(
                        id: x.id,
                        last4: x.last4,
                        typeId: x.typeId,
                        typeLabel: x.typeLabel,
                        phone: x.phone,
                        balanceFcfa: x.balanceFcfa,
                        availableFcfa: x.availableFcfa,
                        active: activate,
                      ),
                    );
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      activate ? 'Carte activée (mock).' : 'Carte désactivée (mock).',
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
    BuildContext context, WidgetRef ref, WalletCard c) async {
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
                  initialValue: c.id,
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
                  onPressed: () {
                    if (!(formKey.currentState?.validate() ?? false)) return;
                    step.value = 1;
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
                  onPressed: () {
                    if (otp.text != '482916') {
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        const SnackBar(
                            content: Text('OTP incorrect (démo : 482916).')),
                      );
                      return;
                    }
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Retrait finalisé (mock).')),
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
    BuildContext context, WalletCard from, List<WalletCard> all) async {
  final others = all.where((e) => e.id != from.id).toList();
  if (others.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Aucune autre carte pour le transfert.')),
    );
    return;
  }

  final amount = TextEditingController();
  final last4 = TextEditingController(text: from.last4);
  var toId = others.first.id;

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
            Text('Depuis ${from.id}', style: Theme.of(ctx).textTheme.bodySmall),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey<String>(toId),
              initialValue: toId,
              decoration: const InputDecoration(labelText: 'Vers carte'),
              items: [
                for (final o in others)
                  DropdownMenuItem(
                    value: o.id,
                    child: Text('${o.id} ••${o.last4}'),
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
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Transfert vers $toId simulé.')),
                );
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

Future<void> showTransactionsSheet(BuildContext context, WalletCard c) async {
  final q = TextEditingController();
  const mockTx = [
    'Paiement POS · +12 500 FCFA',
    'Recharge · +50 000 FCFA',
    'Retrait · -8 000 FCFA',
  ];

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setSt) {
        final filtered = mockTx
            .where((t) => t.toLowerCase().contains(q.text.toLowerCase()))
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
                  onChanged: (_) => setSt(() {}),
                ),
              ),
              SizedBox(
                height: 280,
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (_, i) => ListTile(
                    leading: const Icon(Icons.swap_horiz_rounded),
                    title: Text(filtered[i]),
                    subtitle: Text('Carte ${c.id}'),
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

Future<void> showLiveBalanceDialog(BuildContext context, WalletCard c) async {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );
  final bal = await MockRepository.instance.fetchCardBalance(c.id);
  if (!context.mounted) return;
  Navigator.of(context).pop();
  final money = NumberFormat('#,###', 'fr_FR');
  showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Solde temps réel'),
      content: Text(
        '${money.format(bal.toInt())} FCFA\n(carte ${c.id}, valeur simulée).',
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
