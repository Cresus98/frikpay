import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/data/mock/mock_repository.dart';
import 'package:fripay/data/mock/models.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/providers/mock_providers.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/views/pages/home/encaissement/encaissement_wait_overlay.dart';
import 'package:go_router/go_router.dart';

class EncaissementFormPage extends ConsumerStatefulWidget {
  const EncaissementFormPage({super.key});

  @override
  ConsumerState<EncaissementFormPage> createState() =>
      _EncaissementFormPageState();
}

class _EncaissementFormPageState extends ConsumerState<EncaissementFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _phone = TextEditingController();
  final _note = TextEditingController();
  final _amount = TextEditingController();
  String _method = 'Moov Money';

  @override
  void dispose() {
    _phone.dispose();
    _note.dispose();
    _amount.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final repo = MockRepository.instance;
    final id = repo.nextEncId();
    final dev = ref.read(selectedDevAccountProvider);
    if (dev == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aucun compte Dev sélectionné.')),
        );
      }
      return;
    }

    ref.read(encaissementsProvider.notifier).add(
          EncaissementEntry(
            id: id,
            method: _method,
            phone: _phone.text.trim(),
            amountFcfa: int.parse(_amount.text.replaceAll(RegExp(r'\s'), '')),
            status: 'en_cours',
            createdAt: DateTime.now(),
            note: _note.text.trim().isEmpty ? null : _note.text.trim(),
          ),
        );

    if (!mounted) return;
    await runEncaissementProcessingDialog(
      context: context,
      ref: ref,
      encId: id,
    );
    if (!mounted) return;

    EncaissementEntry? done;
    for (final e in ref.read(encaissementsProvider)) {
      if (e.id == id) done = e;
    }
    final status = done?.status ?? '';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          status == 'termine'
              ? 'Encaissement réussi (mock).'
              : status == 'echec'
                  ? 'Échec réseau (mock). Relancez depuis la liste.'
                  : 'Encaissement mis à jour.',
        ),
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text('Nouvel encaissement'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'L’opération sera associée au compte Dev : '
              '${ref.watch(selectedDevAccountProvider)?.name ?? "—"}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              initialValue: _method,
              decoration: InputDecoration(
                labelText: l10n.txn_network,
                prefixIcon:
                    Icon(Icons.payments_rounded, color: scheme.primary),
              ),
              items: [
                DropdownMenuItem(value: 'Moov Money', child: Text(l10n.txn_moov)),
                DropdownMenuItem(value: 'MTN Mobile Money', child: Text(l10n.txn_mtn)),
              ],
              onChanged: (v) => setState(() => _method = v ?? _method),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: l10n.txn_phone,
                prefixIcon:
                    Icon(Icons.phone_android_rounded, color: scheme.primary),
              ),
              validator: (v) =>
                  (v == null || v.trim().length < 8) ? l10n.error : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amount,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: l10n.txn_amount,
                prefixIcon: Icon(Icons.money_rounded, color: scheme.primary),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return l10n.error;
                final n = int.tryParse(v);
                if (n == null || n < 100) return l10n.error;
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _note,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Référence / note (optionnel)',
                prefixIcon: Icon(Icons.short_text_rounded),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Après validation : file d’attente (2–3 min en production ; '
              '${demoEncaissementWait.inSeconds} s en démo). En cas d’échec simulé, '
              'utilisez « Relancer » sur la ligne.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurface.withValues(alpha: 0.65),
                  ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _submit,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
              ),
              child: Text(l10n.txn_confirm_encaissement),
            ),
          ],
        ),
      ),
    );
  }
}
