import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/config/payment_methods.dart';
import 'package:fripay/data/repository_providers.dart';
import 'package:fripay/models/encaissement_entry.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:fripay/widgets/app_page_header.dart';

class EncaissementPage extends ConsumerStatefulWidget {
  const EncaissementPage({super.key});

  @override
  ConsumerState<EncaissementPage> createState() => _EncaissementPageState();
}

class _EncaissementPageState extends ConsumerState<EncaissementPage> {
  List<EncaissementEntry> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final repo = ref.read(encaissementRepositoryProvider);
      final list = await repo.list();
      if (mounted) {
        setState(() {
          _items = list;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Chargement impossible : $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      content: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: AppHeaderBar(title: 'Encaisser'),
              ),
              Expanded(
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : _items.isEmpty
                        ? const Center(child: Text('Aucun encaissement pour le moment.'))
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                            itemCount: _items.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 8),
                            itemBuilder: (context, i) {
                              final e = _items[i];
                              return Card(
                                child: ListTile(
                                  title: Text('${e.method} · ${e.phone}'),
                                  subtitle: Text(
                                    _statusLabel(e.status),
                                    style: TextStyle(
                                      color: _statusColor(e.status),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: Text(
                                    _formatDate(e.createdAt),
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
          Positioned(
            right: 12,
            bottom: 12,
            child: FloatingActionButton.extended(
              heroTag: 'fab_encaissement',
              onPressed: _openForm,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Ajouter un encaissement'),
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(EncaissementStatus s) {
    switch (s) {
      case EncaissementStatus.enAttente:
        return 'En attente';
      case EncaissementStatus.enCours:
        return 'En cours…';
      case EncaissementStatus.termine:
        return 'Terminé';
      case EncaissementStatus.echec:
        return 'Échec';
    }
  }

  Color _statusColor(EncaissementStatus s) {
    switch (s) {
      case EncaissementStatus.termine:
        return Colors.green;
      case EncaissementStatus.echec:
        return Colors.red;
      case EncaissementStatus.enCours:
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')} ${d.hour}:${d.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _openForm() async {
    String? method = kDefaultPaymentMethods.first;
    final phoneCtrl = TextEditingController();
    final extraCtrl = TextEditingController();

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
                    'Nouvel encaissement',
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
                      hintText: '+229 …',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: extraCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Autres informations (optionnel)',
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      if (phoneCtrl.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Indiquez le numéro de téléphone.')),
                        );
                        return;
                      }
                      Navigator.pop(ctx, true);
                    },
                    child: const Text('Valider et lancer'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );

    if (ok != true || !mounted) return;

    try {
      final repo = ref.read(encaissementRepositoryProvider);
      final entry = await repo.create(
        method: method ?? kDefaultPaymentMethods.first,
        phone: phoneCtrl.text.trim(),
        extraNote: extraCtrl.text.trim().isEmpty ? null : extraCtrl.text.trim(),
      );
      if (!mounted) return;
      setState(() => _items.insert(0, entry));
      await _showWaitingOverlay(entry);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Création impossible : $e')),
        );
      }
    }
  }

  /// Attente max 3 min, puis disparition ; l’utilisateur pourra relancer une nouvelle demande.
  Future<void> _showWaitingOverlay(EncaissementEntry entry) async {
    const maxSeconds = 180;
    if (!mounted) return;

    var remaining = maxSeconds;
    Timer? tick;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setSt) {
            tick ??= Timer.periodic(const Duration(seconds: 1), (t) {
              if (remaining <= 0) {
                t.cancel();
                return;
              }
              remaining--;
              if (remaining <= 0) {
                t.cancel();
                Navigator.of(dialogContext).pop();
                if (!mounted) return;
                setState(() => entry.status = EncaissementStatus.enAttente);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Délai écoulé. Relancez l’encaissement depuis la liste si besoin.',
                    ),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {},
                    ),
                  ),
                );
              } else {
                setSt(() {});
              }
            });
            final minutes = remaining ~/ 60;
            final sec = remaining % 60;
            return AlertDialog(
              title: const Text('Encaissement en cours'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    'Temps restant (max 3 min) : ${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'À la fin du compte à rebours, cette fenêtre disparaît. Vous pourrez relancer l’opération.',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    tick?.cancel();
                    Navigator.of(dialogContext).pop();
                    setState(() => entry.status = EncaissementStatus.enAttente);
                  },
                  child: const Text('Fermer'),
                ),
              ],
            );
          },
        );
      },
    );
    tick?.cancel();
  }
}
