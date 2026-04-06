import 'package:flutter/material.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RetraitPage extends StatefulWidget {
  const RetraitPage({super.key});

  @override
  State<RetraitPage> createState() => _RetraitPageState();
}

class _RetraitPageState extends State<RetraitPage> {
  final _formKey = GlobalKey<FormState>();
  String? mtcn;
  String? nom;
  String? prenoms;
  String? paysResidence;
  String? phoneNumber;
  String? initialCountry = 'BJ';
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text('Retrait'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.receipt_long_rounded, color: scheme.primary),
                  const SizedBox(width: 10),
                  Text(
                    'Vos informations',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'MTCN',
                  prefixIcon: Icon(Icons.tag_rounded,
                      color: scheme.primary.withValues(alpha: 0.75)),
                ),
                onChanged: (value) => mtcn = value,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        prefixIcon: Icon(Icons.badge_outlined,
                            color: scheme.primary.withValues(alpha: 0.75)),
                      ),
                      onChanged: (value) => nom = value,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Prénoms',
                        prefixIcon: Icon(Icons.person_outline_rounded,
                            color: scheme.primary.withValues(alpha: 0.75)),
                      ),
                      onChanged: (value) => prenoms = value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Pays de résidence',
                  prefixIcon: Icon(Icons.public_rounded,
                      color: scheme.primary.withValues(alpha: 0.75)),
                ),
                onChanged: (value) => paysResidence = value,
              ),
              const SizedBox(height: 16),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  phoneNumber = number.phoneNumber;
                },
                initialValue: PhoneNumber(isoCode: initialCountry),
                selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DROPDOWN),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: const TextStyle(color: Colors.black),
                textFieldController: _phoneController,
                formatInput: true,
                keyboardType: TextInputType.phone,
                inputDecoration: InputDecoration(
                  labelText: 'Numéro de téléphone',
                  prefixIcon: Icon(Icons.phone_android_rounded,
                      color: scheme.primary.withValues(alpha: 0.75)),
                ),
              ),
              const Spacer(),
              Center(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(220, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Demande enregistrée (données fictives pour la démo).')),
                    );
                  },
                  child: const Text('Continuer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
