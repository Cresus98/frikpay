import 'package:flutter/material.dart';
import 'package:fripay/models/card_item.dart';

/// Dialogues et feuilles pour les actions sur une carte (champs attendus par l’API).
class CardOperationDialogs {
  CardOperationDialogs._();

  static Future<void> showRecharge(BuildContext context, CardItem card) async {
    final amount = TextEditingController();
    final last4 = TextEditingController(text: card.last4);
    final phone = TextEditingController(text: card.phone);

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Recharger la carte'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Carte (interne) : ${card.id}', style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 8),
              TextField(
                controller: amount,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Montant'),
              ),
              TextField(
                controller: last4,
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: const InputDecoration(labelText: '4 derniers chiffres'),
              ),
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Numéro de téléphone'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Annuler')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Envoyer'),
          ),
        ],
      ),
    );
  }

  static Future<void> showToggle(
    BuildContext context,
    CardItem card, {
    required bool activate,
  }) async {
    final last4 = TextEditingController(text: card.last4);
    final phone = TextEditingController(text: card.phone);

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(activate ? 'Activer la carte' : 'Désactiver la carte'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: last4,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(labelText: '4 derniers chiffres'),
            ),
            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Téléphone associé'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Annuler')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
  }

  static Future<void> showRetrait(BuildContext context, CardItem card) async {
    final amount = TextEditingController();
    final last4 = TextEditingController(text: card.last4);
    final phone = TextEditingController(text: card.phone);
    final otp = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Retrait sur la carte'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amount,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Montant à débiter'),
              ),
              TextField(
                controller: last4,
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: const InputDecoration(labelText: '4 derniers chiffres'),
              ),
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Téléphone associé'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: otp,
                decoration: const InputDecoration(
                  labelText: 'OTP (après envoi)',
                  hintText: 'Saisir l’OTP reçu pour finaliser',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Annuler')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Valider'),
          ),
        ],
      ),
    );
  }

  static Future<void> showDetails(BuildContext context, CardItem card) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Détails de la carte'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Id : ${card.id}'),
            Text('Masque : ${card.maskedPan}'),
            Text('Téléphone : ${card.phone}'),
            Text('Statut : ${card.isActive ? "Active" : "Inactive"}'),
            if (card.label.isNotEmpty) Text('Libellé : ${card.label}'),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  static Future<void> showTransfert(BuildContext context, CardItem from) async {
    final toId = TextEditingController();
    final amount = TextEditingController();
    final last4 = TextEditingController(text: from.last4);

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Transfert carte à carte'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Depuis : ${from.id}'),
            TextField(
              controller: toId,
              decoration: const InputDecoration(
                labelText: 'Id / identifiant carte destination',
              ),
            ),
            TextField(
              controller: amount,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Montant'),
            ),
            TextField(
              controller: last4,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(labelText: '4 derniers chiffres'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Annuler')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Transférer'),
          ),
        ],
      ),
    );
  }

  static Future<void> showTransactions(BuildContext context, CardItem card) async {
    final search = TextEditingController();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.95,
          minChildSize: 0.4,
          builder: (_, scroll) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Transactions — ${card.maskedPan}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: search,
                    decoration: const InputDecoration(
                      labelText: 'Recherche',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      controller: scroll,
                      children: List.generate(
                        8,
                        (i) => ListTile(
                          title: Text('Transaction $i'),
                          subtitle: const Text('Montant / statut (API)'),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> fetchSolde(BuildContext context, CardItem card) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (context.mounted) Navigator.of(context).pop();
    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Solde en temps réel'),
        content: Text(
          'Solde pour ${card.maskedPan} (id ${card.id}) :\n— à brancher sur l’API',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
