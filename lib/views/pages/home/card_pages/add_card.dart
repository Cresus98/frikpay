
import 'package:flutter/material.dart';
import 'package:fripay/models/card_item.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import 'card_operation_dialogs.dart';


class MyCardsPage extends StatefulWidget {
  const MyCardsPage({super.key});

  @override
  State<MyCardsPage> createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  final List<CardItem> _cards = [
    const CardItem(
      id: 'card-int-7821',
      maskedPan: '**** **** **** 4242',
      last4: '4242',
      phone: '+229 97 00 00 00',
      label: 'Visa principale',
      isActive: true,
    ),
    const CardItem(
      id: 'card-int-9901',
      maskedPan: '**** **** **** 8899',
      last4: '8899',
      phone: '+229 90 12 34 56',
      label: 'Carte secondaire',
      isActive: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Mes cartes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: _cards.isEmpty
          ? const Center(child: Text('Aucune carte. Ajoutez-en une.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _cards.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final c = _cards[i];
                return Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    c.maskedPan,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    c.label,
                                    style: TextStyle(color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    c.isActive ? 'Active' : 'Inactive',
                                    style: TextStyle(
                                      color: c.isActive ? Colors.green : Colors.orange,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (v) => _onAction(v, c),
                              itemBuilder: (context) => const [
                                PopupMenuItem(value: 'recharge', child: Text('Recharger')),
                                PopupMenuItem(value: 'desactiver', child: Text('Désactiver')),
                                PopupMenuItem(value: 'activer', child: Text('Activer')),
                                PopupMenuItem(value: 'retrait', child: Text('Retrait')),
                                PopupMenuItem(value: 'details', child: Text('Détails')),
                                PopupMenuItem(value: 'transfert', child: Text('Transfert carte à carte')),
                                PopupMenuItem(value: 'transactions', child: Text('Transactions')),
                                PopupMenuItem(value: 'solde', child: Text('Solde')),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            OutlinedButton(
                              onPressed: () => CardOperationDialogs.showRecharge(context, c),
                              child: const Text('Recharger'),
                            ),
                            OutlinedButton(
                              onPressed: () => CardOperationDialogs.showToggle(
                                context,
                                c,
                                activate: !c.isActive,
                              ),
                              child: Text(c.isActive ? 'Désactiver' : 'Activer'),
                            ),
                            OutlinedButton(
                              onPressed: () => CardOperationDialogs.showDetails(context, c),
                              child: const Text('Détails'),
                            ),
                            OutlinedButton(
                              onPressed: () => CardOperationDialogs.fetchSolde(context, c),
                              child: const Text('Solde'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'fab_cards',
        onPressed: () => context.pushNamed(RoutesNames.Home1),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Ajouter une carte'),
      ),
    );
  }

  Future<void> _onAction(String action, CardItem c) async {
    switch (action) {
      case 'recharge':
        await CardOperationDialogs.showRecharge(context, c);
        break;
      case 'desactiver':
        await CardOperationDialogs.showToggle(context, c, activate: false);
        break;
      case 'activer':
        await CardOperationDialogs.showToggle(context, c, activate: true);
        break;
      case 'retrait':
        await CardOperationDialogs.showRetrait(context, c);
        break;
      case 'details':
        await CardOperationDialogs.showDetails(context, c);
        break;
      case 'transfert':
        await CardOperationDialogs.showTransfert(context, c);
        break;
      case 'transactions':
        await CardOperationDialogs.showTransactions(context, c);
        break;
      case 'solde':
        await CardOperationDialogs.fetchSolde(context, c);
        break;
    }
  }
}
