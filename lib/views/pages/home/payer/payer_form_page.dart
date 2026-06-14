import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/data/mock/mock_repository.dart';
import 'package:fripay/data/mock/models.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/providers/mock_providers.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class PayerFormPage extends ConsumerStatefulWidget {
  const PayerFormPage({super.key});

  @override
  ConsumerState<PayerFormPage> createState() => _PayerFormPageState();
}

class _PayerFormPageState extends ConsumerState<PayerFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _phone = TextEditingController();
  final _amount = TextEditingController();
  String _method = 'Moov Money';

  @override
  void dispose() {
    _phone.dispose();
    _amount.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (ref.read(selectedDevAccountProvider) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compte Dev manquant.')),
      );
      return;
    }
    final repo = MockRepository.instance;
    ref.read(paymentsProvider.notifier).add(
          PaymentEntry(
            id: repo.nextPayId(),
            method: _method,
            phone: _phone.text.trim(),
            amountFcfa:
                int.parse(_amount.text.replaceAll(RegExp(r'\s'), '')),
            status: 'termine',
            at: DateTime.now(),
          ),
        );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Paiement enregistré (simulation).')),
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
        title: const Text('Nouveau paiement'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Utilisez la clé affichée sur l’écran « Payer » côté commerçant / intégration.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              initialValue: _method,
              decoration: InputDecoration(
                labelText: l10n.txn_network,
                prefixIcon:
                    Icon(Icons.cell_tower_rounded, color: scheme.primary),
              ),
              items: [
                DropdownMenuItem(value: 'Moov Money', child: Text(l10n.txn_moov)),
                DropdownMenuItem(
                    value: 'MTN Mobile Money', child: Text(l10n.txn_mtn)),
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
                prefixIcon: Icon(Icons.payments_rounded, color: scheme.primary),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return l10n.error;
                final n = int.tryParse(v);
                if (n == null || n < 100) return l10n.error;
                return null;
              },
            ),
            const SizedBox(height: 28),
            FilledButton(
              onPressed: _submit,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
              ),
              child: Text(l10n.txn_confirm_paiement),
            ),
          ],
        ),
      ),
    );
  }
}
