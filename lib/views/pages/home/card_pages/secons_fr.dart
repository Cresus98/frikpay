import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/data/mock/mock_repository.dart';
import 'package:fripay/data/mock/models.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/providers/mock_providers.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/utils/card_expiry.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AddCardPage extends ConsumerStatefulWidget {
  const AddCardPage({super.key});

  @override
  ConsumerState<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends ConsumerState<AddCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _number = TextEditingController();
  final _expiry = TextEditingController();
  final _cvv = TextEditingController();
  final _holder = TextEditingController();
  final _phone = TextEditingController();
  bool _saveForFuture = true;

  List<CardTypeOption> _types = [];
  String? _typeId;
  bool _loadingTypes = true;

  @override
  void initState() {
    super.initState();
    _loadTypes();
  }

  Future<void> _loadTypes() async {
    final list = await MockRepository.instance.fetchCardTypes();
    if (!mounted) return;
    setState(() {
      _types = list;
      _typeId = list.isNotEmpty ? list.first.id : null;
      _loadingTypes = false;
    });
  }

  @override
  void dispose() {
    _number.dispose();
    _expiry.dispose();
    _cvv.dispose();
    _holder.dispose();
    _phone.dispose();
    super.dispose();
  }

  String? _validateExpiry(String? v, AppLocalizations l10n) {
    final code = CardExpiry.validateCode(v);
    switch (code) {
      case 'empty':
        return l10n.error;
      case 'incomplete':
        return l10n.expiry_incomplete;
      case 'month':
        return l10n.expiry_month;
      case 'expired':
        return l10n.expiry_expired;
      default:
        return null;
    }
  }

  String _last4(String digits) {
    if (digits.isEmpty) return '0000';
    if (digits.length >= 4) return digits.substring(digits.length - 4);
    return digits.padLeft(4, '0');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final feeFmt = NumberFormat('#,###', 'fr_FR');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.add_card),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            Text(
              l10n.cards_subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurface.withValues(alpha: 0.65),
                  ),
            ),
            const SizedBox(height: 16),
            if (_loadingTypes)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_types.isEmpty)
              Text(
                'Aucun type de carte (mock).',
                style: TextStyle(color: scheme.error),
              )
            else ...[
              DropdownButtonFormField<String>(
                initialValue: _typeId,
                decoration: InputDecoration(
                  labelText: 'Type de carte (API mock)',
                  prefixIcon:
                      Icon(Icons.category_rounded, color: scheme.primary),
                ),
                items: [
                  for (final t in _types)
                    DropdownMenuItem(
                      value: t.id,
                      child: Text(
                        '${t.label} — ${feeFmt.format(t.issueFeeFcfa)} FCFA',
                      ),
                    ),
                ],
                onChanged: (v) => setState(() => _typeId = v),
              ),
              Builder(
                builder: (context) {
                  CardTypeOption? t;
                  for (final x in _types) {
                    if (x.id == _typeId) t = x;
                  }
                  if (t == null) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6, left: 4),
                    child: Text(
                      'Frais d’émission indicatifs : ${feeFmt.format(t.issueFeeFcfa)} FCFA',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onSurface.withValues(alpha: 0.6),
                          ),
                    ),
                  );
                },
              ),
            ],
            const SizedBox(height: 22),
            TextFormField(
              controller: _holder,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Titulaire',
                prefixIcon: Icon(Icons.person_outline_rounded,
                    color: scheme.primary.withValues(alpha: 0.85)),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.error : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Téléphone associé à la carte',
                prefixIcon: Icon(Icons.phone_android_rounded,
                    color: scheme.primary.withValues(alpha: 0.85)),
              ),
              validator: (v) =>
                  (v == null || v.trim().length < 8) ? l10n.error : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _number,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(19),
                _CardNumberSpacingFormatter(),
              ],
              decoration: InputDecoration(
                labelText: l10n.add_card1,
                hintText: '0000 0000 0000 0000',
                prefixIcon: Icon(Icons.credit_card_rounded,
                    color: scheme.primary.withValues(alpha: 0.85)),
              ),
              validator: (v) {
                final d = (v ?? '').replaceAll(RegExp(r'\s'), '');
                if (d.length < 13) return l10n.error;
                return null;
              },
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    controller: _expiry,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      CardExpiryInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      labelText: '${l10n.add_card2} (MM/AA)',
                      hintText: 'MM / AA',
                      prefixIcon: Icon(Icons.calendar_month_rounded,
                          color: scheme.primary.withValues(alpha: 0.85)),
                    ),
                    validator: (v) => _validateExpiry(v, l10n),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: _cvv,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      prefixIcon: Icon(Icons.shield_outlined,
                          color: scheme.primary.withValues(alpha: 0.85)),
                    ),
                    validator: (v) {
                      if (v == null || v.length < 3) return l10n.error;
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _saveForFuture,
              onChanged: (v) => setState(() => _saveForFuture = v),
              title: Text(
                'Mémoriser pour les prochains paiements',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              secondary: Icon(Icons.save_outlined, color: scheme.primary),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _loadingTypes || _types.isEmpty || _typeId == null
                  ? null
                  : () {
                      if (!(_formKey.currentState?.validate() ?? false)) {
                        return;
                      }
                      CardTypeOption? type;
                      for (final x in _types) {
                        if (x.id == _typeId) type = x;
                      }
                      if (type == null) return;

                      final digits =
                          _number.text.replaceAll(RegExp(r'\s'), '');
                      final card = WalletCard(
                        id: MockRepository.instance.nextCardId(),
                        last4: _last4(digits),
                        typeId: type.id,
                        typeLabel: type.label,
                        phone: _phone.text.trim(),
                        balanceFcfa: 0,
                        availableFcfa: 0,
                        active: true,
                      );
                      MockRepository.instance.registerMockCard(card);
                      ref.read(walletCardsProvider.notifier).add(card);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${l10n.suc} (${type.label}, '
                            '${feeFmt.format(type.issueFeeFcfa)} FCFA).',
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppRadius.sm),
                          ),
                        ),
                      );
                      context.pop();
                    },
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
              ),
              child: Text(l10n.val),
            ),
          ],
        ),
      ),
    );
  }
}

/// Garde uniquement les chiffres et réinsère des espaces par groupes de 4.
class _CardNumberSpacingFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var d = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (d.length > 16) d = d.substring(0, 16);
    final display = _RawFormat.cardGroups(d);
    return TextEditingValue(
      text: display,
      selection: TextSelection.collapsed(offset: display.length),
    );
  }
}

class _RawFormat {
  static String cardGroups(String digits) {
    final b = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) b.write(' ');
      b.write(digits[i]);
    }
    return b.toString();
  }
}
