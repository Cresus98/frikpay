import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

enum MobileMoneyFlow { encaisser, payer }

class EncaisserPage extends StatelessWidget {
  const EncaisserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MobileMoneyScreen(flow: MobileMoneyFlow.encaisser);
  }
}

class PayerPage extends StatelessWidget {
  const PayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MobileMoneyScreen(flow: MobileMoneyFlow.payer);
  }
}

class MobileMoneyScreen extends StatefulWidget {
  const MobileMoneyScreen({super.key, required this.flow});

  final MobileMoneyFlow flow;

  @override
  State<MobileMoneyScreen> createState() => _MobileMoneyScreenState();
}

class _MobileMoneyScreenState extends State<MobileMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _phone = TextEditingController();
  String _network = 'moov';

  @override
  void dispose() {
    _amount.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isEncaisser = widget.flow == MobileMoneyFlow.encaisser;
    final title = isEncaisser ? l10n.encaisser : l10n.payer;
    final icon =
        isEncaisser ? Icons.south_west_rounded : Icons.north_east_rounded;
    final accent = isEncaisser ? const Color(0xFF059669) : scheme.primary;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            Icon(icon, size: 22, color: scheme.onSurface),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded, color: accent, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.txn_demo,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              height: 1.35,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _amount,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: l10n.txn_amount,
                prefixIcon: Icon(Icons.payments_outlined, color: accent),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return l10n.error;
                if (int.tryParse(v) == null || int.parse(v) < 100) {
                  return l10n.error;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _network,
              decoration: InputDecoration(
                labelText: l10n.txn_network,
                prefixIcon: Icon(Icons.cell_tower_rounded, color: accent),
              ),
              items: [
                DropdownMenuItem(
                  value: 'moov',
                  child: Text(l10n.txn_moov),
                ),
                DropdownMenuItem(
                  value: 'mtn',
                  child: Text(l10n.txn_mtn),
                ),
              ],
              onChanged: (v) => setState(() => _network = v ?? 'moov'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d+\s]')),
              ],
              decoration: InputDecoration(
                labelText: l10n.txn_phone,
                hintText: '+229 …',
                prefixIcon: Icon(Icons.phone_android_rounded, color: accent),
              ),
              validator: (v) {
                if (v == null || v.trim().length < 8) return l10n.error;
                return null;
              },
            ),
            const SizedBox(height: 28),
            FilledButton(
              onPressed: () {
                if (!(_formKey.currentState?.validate() ?? false)) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.suc),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                  ),
                );
                context.pop();
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                backgroundColor: accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
              ),
              child: Text(
                isEncaisser
                    ? l10n.txn_confirm_encaissement
                    : l10n.txn_confirm_paiement,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
