import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/data/repository_providers.dart';
import 'package:fripay/models/payment_record.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:fripay/widgets/app_page_header.dart';
import 'package:intl/intl.dart';

import 'package:fripay/config/payment_methods.dart';

/// Écran « Payer » : clé d’application, soldes, liste des paiements, formulaire.
class PayerPage extends ConsumerStatefulWidget {
  const PayerPage({super.key});

  @override
  ConsumerState<PayerPage> createState() => _PayerPageState();
}

class _PayerPageState extends ConsumerState<PayerPage> {
  String _appKey = '';
  double _solde = 0;
  double _soldeDisponible = 0;
  List<PaymentRecord> _payments = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final repo = ref.read(payerRepositoryProvider);
      final d = await repo.load();
      if (!mounted) return;
      setState(() {
        _appKey = d.appKey;
        _solde = d.solde;
        _soldeDisponible = d.soldeDisponible;
        _payments = d.payments;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = '$e';
      });
    }
  }

  Future<void> _openPaymentForm() async {
    String? method = kDefaultPaymentMethods.first;
    final phoneCtrl = TextEditingController();
    final amountCtrl = TextEditingController();

    final ok = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: StatefulBuilder(
            builder: (context, setModal) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Nouveau paiement',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: method,
                    decoration: const InputDecoration(labelText: 'Moyen de paiement'),
                    items: kDefaultPaymentMethods
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setModal(() => method = v),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Numéro de téléphone',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: amountCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Montant à payer',
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      final a = double.tryParse(
                        amountCtrl.text.replaceAll(',', '.').trim(),
                      );
                      if (phoneCtrl.text.trim().isEmpty || a == null || a <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Téléphone et montant valides requis.'),
                          ),
                        );
                        return;
                      }
                      Navigator.pop(ctx, true);
                    },
                    child: const Text('Valider'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );

    if (ok != true || !mounted) return;

    final amount = double.tryParse(
      amountCtrl.text.replaceAll(',', '.').trim(),
    );
    if (amount == null) return;

    try {
      final repo = ref.read(payerRepositoryProvider);
      await repo.createPayment(
        method: method ?? kDefaultPaymentMethods.first,
        phone: phoneCtrl.text.trim(),
        amount: amount,
      );
      if (!mounted) return;
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Paiement enregistré.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'fr_FR', symbol: 'FCFA');
    return GeneralScaffold(
      content: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: AppHeaderBar(title: 'Payer'),
              ),
              if (_loading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_error != null)
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_error!, textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          FilledButton(
                            onPressed: _load,
                            child: const Text('Réessayer'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else ...[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Clé d’application (paiement)',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          SelectableText(
                            _appKey,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Selon l’application active, le système fournit cette clé pour autoriser les paiements.',
                            style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    color: Theme.of(context).colorScheme.secondaryContainer.withValues(
                          alpha: 0.65,
                        ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Soldes', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Solde'),
                              Text(
                                currency.format(_solde),
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Solde disponible'),
                              Text(
                                currency.format(_soldeDisponible),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green.shade800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'Mes paiements',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: _payments.isEmpty
                      ? const Center(child: Text('Aucun paiement enregistré.'))
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                          itemCount: _payments.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 8),
                          itemBuilder: (context, i) {
                            final p = _payments[i];
                            return Card(
                              child: ListTile(
                                title: Text('${p.method} · ${p.phone}'),
                                subtitle: Text(
                                  '${p.date.day}/${p.date.month}/${p.date.year} ${p.date.hour}:${p.date.minute.toString().padLeft(2, '0')}',
                                ),
                                trailing: Text(
                                  currency.format(p.amount),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ],
          ),
          if (!_loading && _error == null)
            Positioned(
              right: 12,
              bottom: 12,
              child: FloatingActionButton.extended(
                heroTag: 'fab_payer',
                onPressed: _openPaymentForm,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Nouveau paiement'),
              ),
            ),
        ],
      ),
    );
  }
}
