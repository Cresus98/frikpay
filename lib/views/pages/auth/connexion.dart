import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/views/utils/extensions.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:go_router/go_router.dart';

import '../../../gen/assets.gen.dart';
import '../../routes.dart' show RoutesNames;
import '../../utils/globalwidget/app_textform.dart' show AuthTextformField;
import '../../utils/globalwidget/buttons/bigbutton.dart' show BigButton;
import '../../utils/globalwidget/dialogs.dart' show openDialogBox, CustomAlertDialog;
import '../../utils/globalwidget/space.dart' show Space;

class Connexion extends ConsumerStatefulWidget {
  const Connexion({super.key});

  @override
  ConsumerState<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends ConsumerState<Connexion> {
  final TextEditingController id_controller = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool obscure = true;
  final globaykey = GlobalKey<FormState>();

  @override
  void dispose() {
    id_controller.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return GeneralScaffold(
      content: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: context.screenHeight - 40),
          child: Form(
            key: globaykey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Assets.images.logoFripaySvg.svg(
                    height: 64,
                    width: 64,
                    fit: BoxFit.cover,
                  ),
                ),
                Space.verticale(heigth: 16),
                Text(
                  'FinanfaSend',
                  textAlign: TextAlign.center,
                  style: context.textStyle(
                    colour: scheme.onSurface,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Space.verticale(heigth: 6),
                Text(
                  l10n.login1,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.6),
                      ),
                ),
                Space.verticale(heigth: 28),
                AuthTextformField(
                  suffix: false,
                  next: true,
                  cas: 2,
                  hintext: l10n.register1,
                  prefixIcon: Icons.alternate_email_rounded,
                  onClick: () {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.error;
                    }
                    return null;
                  },
                  label: l10n.register1,
                  controller: id_controller,
                ),
                Space.verticale(heigth: 4),
                AuthTextformField(
                  suffix: true,
                  next: false,
                  cas: 2,
                  hintext: l10n.login2,
                  prefixIcon: Icons.lock_outline_rounded,
                  onClick: () {
                    obscure = !obscure;
                    setState(() {});
                  },
                  obscure: obscure,
                  input_type: TextInputType.visiblePassword,
                  iconData: obscure ? Icons.visibility_off : Icons.visibility,
                  label: l10n.login2,
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.error;
                    return null;
                  },
                  controller: password,
                ),
                Space.verticale(heigth: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      text: l10n.forgotpass,
                      style: TextStyle(
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            context.pushNamed(RoutesNames.ForgotPassword),
                    ),
                  ),
                ),
                Space.verticale(heigth: 16),
                BigButton(
                  labelText: l10n.login,
                  backgroundClr: scheme.primary,
                  color: scheme.onPrimary,
                  fixedSized: const Size(350, 50),
                  size: 16,
                  circle: AppRadius.sm,
                  buttonSide: BorderSide(color: scheme.primary, width: 1),
                  fontWeight: FontWeight.w600,
                  onPressed: () => _seconnecter(context),
                ),
                Space.verticale(heigth: 10),
                BigButton(
                  labelText: l10n.register6,
                  backgroundClr: scheme.surface,
                  color: scheme.primary,
                  fixedSized: const Size(350, 50),
                  size: 16,
                  circle: AppRadius.sm,
                  buttonSide: BorderSide(color: scheme.primary, width: 1),
                  fontWeight: FontWeight.w600,
                  onPressed: () => context.pushNamed(RoutesNames.Inscription),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _seconnecter(BuildContext context) async {
    if (!globaykey.currentState!.validate()) return;

    openDialogBox(context, '', const CustomAlertDialog());
    const state = true;

    if (state && context.mounted) {
      context.pop();
      context.goNamed(RoutesNames.Home);
    }
  }
}
