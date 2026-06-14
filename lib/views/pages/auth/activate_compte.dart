import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/views/utils/extensions.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/authview/authview.dart';
import '../../../gen/colors.gen.dart';
import '../../routes.dart';
import '../../utils/globalwidget/app_textform.dart';
import '../../utils/globalwidget/buttons/bigbutton.dart';
import '../../utils/globalwidget/dialogs.dart';
import '../../utils/globalwidget/space.dart';



class ActivationAccountPage extends ConsumerStatefulWidget {
  const ActivationAccountPage({super.key});

  @override
  ConsumerState<ActivationAccountPage> createState() => _ActivationAccountPageState();
}

class _ActivationAccountPageState extends ConsumerState<ActivationAccountPage> {

  final _formKey = GlobalKey<FormState>();

  final _otpControllers = List<TextEditingController>.generate(5, (index) => TextEditingController(),);
  final password = TextEditingController();
  final globakey=GlobalKey<FormState>();
  bool obscure=true;

  // Validation du mot de passe

  bool _hasLetter = false;
  bool _hasUpperLower = false;
  bool _hasDigit = false;
  bool _hasSymbol = false;
  bool _hasMinLength = false;
  final int _minPasswordLength = 8;

  void _validatePassword() {

    setState(() {
      // 1. Contient au moins une lettre
      _hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password.text);

      // 2. Contient au moins une majuscule ET une minuscule
      _hasUpperLower =
          RegExp(r'[a-z]').hasMatch(password.text) &&
              RegExp(r'[A-Z]').hasMatch(password.text);

      // 3. Contient au moins un chiffre
      _hasDigit = RegExp(r'[0-9]').hasMatch(password.text);

      // 4. Contient au moins un symbole
      _hasSymbol = RegExp(
        r'[!@#\$%^&*(),.?":{}|<>_\-+=\[\]\\\/~`]',
      ).hasMatch(password.text);

      // 5. Longueur minimale
      _hasMinLength = password.text.length >= _minPasswordLength;

    });
  }
  @override
  void initState() {
    super.initState();
    password.addListener(_validatePassword);
  }

  bool get _isPasswordValid {
    return _hasLetter &&
        _hasUpperLower &&
        _hasDigit &&
        _hasSymbol &&
        _hasMinLength
    //&&
    //    _passwordsMatch
        ;
  }


  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return GeneralScaffold(
      content: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton.filledTonal(
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.goNamed(RoutesNames.Connexion);
                          }
                        },
                        icon: const Icon(Icons.arrow_back_rounded),
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(AppRadius.sm),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.activation,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l10n.activProcess,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.65),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(5, (index) {
                        return SizedBox(
                          width: 50,
                          child: TextFormField(
                            validator: (value) {
                              if(value!.isEmpty)
                              {
                                return '';
                              }
                              return null;
                            },
                            controller: _otpControllers[index],
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              counterText: "",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0), // Custom radius
                              ),
                            ),
                            onChanged: (value) {
                              if (value.length == 1 && index < 4) {
                                FocusScope.of(context).nextFocus(); // Move to next field
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 15),
                  AuthTextformField(
                      suffix: true,
                      next: false,
                      cas: 2,
                      hintext: AppLocalizations.of(context)!.login2,
                      prefixIcon: Icons.lock_outline_rounded,
                      onClick: () {
                        obscure = !obscure;
                        setState(() {});
                      },
                      obscure: obscure,
                      input_type: TextInputType.visiblePassword,
                      iconData: obscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      label: AppLocalizations.of(context)!.login2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.error;
                        }
                        return null;
                      },
                      controller: password),
                    const SizedBox(height: 15),
                    _buildPasswordRequirements(),
                    const SizedBox(height: 28),
                    FilledButton.icon(
                      onPressed: ()
                      {

                        if(_isPasswordValid){
                        _activateAccount(context);}
                      }
                      ,
                      style: FilledButton.styleFrom(
                        backgroundColor:  scheme.primary,
                        disabledBackgroundColor: Colors.grey.shade300,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: _isPasswordValid ? 2 : 0,
                      ),
                      icon: const Icon(Icons.mark_email_read_outlined, size: 22),
                      label: Text(l10n.active,style:TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _isPasswordValid
                            ? Colors.white
                            : Colors.grey.shade600,
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _activateAccount(BuildContext context)  async{



    String cde=_otpControllers.map((controller) => controller.text).join();

    if(cde.length==5)
    {
      openDialogBox(context,"",const CustomAlertDialog(
        alertLoadingCase: AlertLoadingCase.Auth,
      ));

      bool state = await ref.read(authviewProvider.notifier).activation_compte(
          code: cde,password: password.text);
      if (state && context.mounted) {
        context.pop();
        context.goNamed(RoutesNames.Connexion);
      }
    }

  }

  Widget _buildPasswordRequirements() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Le mot de passe doit contenir :',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 12),
          _buildPasswordRequirement(
            text: 'Au moins une lettre',
            isValid: _hasLetter,
          ),
          const SizedBox(height: 8),
          _buildPasswordRequirement(
            text: 'Une lettre majuscule et une minuscule',
            isValid: _hasUpperLower,
          ),
          const SizedBox(height: 8),
          _buildPasswordRequirement(
            text: 'Au moins un chiffre (0-9)',
            isValid: _hasDigit,
          ),
          const SizedBox(height: 8),
          _buildPasswordRequirement(
            text: 'Au moins un symbole (!@#\$%...)',
            isValid: _hasSymbol,
          ),
          const SizedBox(height: 8),
          _buildPasswordRequirement(
            text: 'Au moins $_minPasswordLength caractères',
            isValid: _hasMinLength,
          ),
        ],
      ),
    );
  }
  Widget _buildPasswordRequirement({
    required String text,
    required bool isValid,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isValid ? Colors.green.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isValid ? Colors.green.shade300 : Colors.grey.shade300,
          width: isValid ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isValid ? Colors.green.shade600 : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: isValid ? Colors.green.shade600 : Colors.grey.shade400,
                width: 2,
              ),
            ),
            child: isValid
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isValid ? FontWeight.w600 : FontWeight.w500,
                color: isValid ? Colors.green.shade700 : Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}