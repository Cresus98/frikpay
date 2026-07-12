import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fripay/views/utils/extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../controllers/authview/authview.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../l10n/app_localizations.dart';
import '../../../theme/app_theme.dart';
import '../../routes.dart';
import '../../utils/constantes.dart';
import '../../utils/globalwidget/app_textform.dart';
import '../../utils/globalwidget/buttons/back_button.dart';
import '../../utils/globalwidget/buttons/bigbutton.dart';
import '../../utils/globalwidget/dialogs.dart';
import '../../utils/globalwidget/general_scaffold.dart' show GeneralScaffold;
import '../../utils/globalwidget/space.dart' show Space;


class Inscription extends ConsumerStatefulWidget {
  const Inscription({super.key});

  @override
  ConsumerState<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends ConsumerState<Inscription> {
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController pseudo = TextEditingController();
  TextEditingController email = TextEditingController();
  //TextEditingController password = TextEditingController();
  TextEditingController company = TextEditingController();

  final numero = TextEditingController();
  String phone_numero = "";
  String pass = "";
  bool num_is_valid = false;
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'BJ', dialCode: "+229");
  bool obscure = true;
  bool ismarchand = true;
  final globaykey = GlobalKey<FormState>();

  @override
  void dispose() {
    nom.dispose();
    prenom.dispose();
    pseudo.dispose();
    email.dispose();
  //  password.dispose();
    company.dispose();
    numero.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return
      GeneralScaffold(
        content:
        //SingleChildScrollView(
          //child:
          SizedBox(
            width: context.screenWidth,
            height: context.screenHeight,
            child: Form(
              key: globaykey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Space.verticale(heigth: 05),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical:2),
                      child: ButtonBack(
                        iconColor:  ColorName.webBlack,
                        //backgroundColor: Colors.grey.withOpacity(0.5),
                        onclick: () {

                          context.pop();
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      child: Text(AppLocalizations.of(context)!.register,
                        style: context.textStyle(
                            colour: Colors.black,fontSize: 25,fontWeight: FontWeight.w900
                        ),),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 1),
                      child: Text(AppLocalizations.of(context)!.register8,
                        textAlign: TextAlign.justify,
                        style: context.textStyle(
                            colour: Colors.black,fontSize: 15,fontWeight: FontWeight.normal
                        ),),
                    ),
                  ),
                  Space.verticale(heigth: 10),
                  Expanded(child:
                  //Column(
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Space.verticale(heigth:10),
                        Assets.images.logoFripaySvg.svg(height: 70, width: 70,fit: BoxFit.cover),
                        Space.verticale(heigth:5),
                        Text(
                          appName,
                          style: context.textStyle(
                            colour: Theme.of(context).colorScheme.onSurface,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Space.verticale(heigth: 10),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            child: AuthTextformField(
                                suffix: false,
                                next: true,
                                cas: 2,
                                hintext: AppLocalizations.of(context)!.register1,
                                prefixIcon: Icons.alternate_email_rounded,
                                onClick: () {},
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return AppLocalizations.of(context)!.error;
                                  }
                                  return null;
                                },
                                label: AppLocalizations.of(context)!.register1,
                                controller: pseudo)),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            child: AuthTextformField(
                                suffix: false,
                                next: true,
                                cas: 2,
                                hintext: AppLocalizations.of(context)!.register2,
                                prefixIcon: Icons.badge_outlined,
                                onClick: () {},
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return AppLocalizations.of(context)!.error;
                                  }
                                  return null;
                                },
                                label: AppLocalizations.of(context)!.register2,
                                controller: nom)),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            child: AuthTextformField(
                                suffix: false,
                                next: true,
                                cas: 2,
                                hintext: AppLocalizations.of(context)!.register3,
                                prefixIcon: Icons.person_outline_rounded,
                                onClick: () {},
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return AppLocalizations.of(context)!.error;
                                  }
                                  return null;
                                },
                                label: AppLocalizations.of(context)!.register3,
                                controller: prenom)),
                        Space.verticale(heigth: 6),
                        Container(
                          padding: const EdgeInsets.only(left: 15),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context)!.register4,
                            style: context.textStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEEEEE).withOpacity(0.35),
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                            border: Border.all(
                              color: const Color(0xFFCBD5E1),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: InternationalPhoneNumberInput(
                                  onInputChanged: (PhoneNumber number) {
                                    phoneNumber = number;
                                  },
                                  onInputValidated: (bool value) {
                                    num_is_valid = value;
                                  },
                                  selectorConfig: const SelectorConfig(
                                    selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                                    setSelectorButtonAsPrefixIcon: false,
                                    leadingPadding: 10,
                                    trailingSpace: false,
                                  ),
                                  ignoreBlank: false,
                                  spaceBetweenSelectorAndTextField: 20,
                                  autoValidateMode: AutovalidateMode.disabled,
                                  selectorTextStyle:
                                  const TextStyle(color: ColorName.webBlack),
                                  textFieldController: numero,
                                  formatInput: false,
                                  //maxLength: 9,
                                  keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                                  cursorColor: ColorName.webBlack,
                                  inputDecoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.only(bottom: 15, left: 0),
                                    border: InputBorder.none,
                                    hintText: '',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade500, fontSize: 16),
                                  ),
                                  onSaved: (PhoneNumber number) {
                                    phone_numero = number.phoneNumber ?? '';
                                  },
                                  initialValue: phoneNumber,
                                  errorMessage: "Numéro invalide ",
                                  searchBoxDecoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.only(bottom: 2, left: 2),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: ColorName.webBlack,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(10)),
                                    hintText: 'Recherchez le pays ',
                                    prefixIcon:
                                    Icon(Icons.search, color: Colors.blue),
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade500, fontSize: 14),
                                  ),
                                ),
                              ),
                         ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            child: AuthTextformField(
                                suffix: false,
                                next: true,
                                cas: 2,
                                hintext: AppLocalizations.of(context)!.register5,
                                prefixIcon: Icons.mail_outline_rounded,
                                onClick: () {},
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return AppLocalizations.of(context)!.error;
                                  }
                                  return null;
                                },
                                label: AppLocalizations.of(context)!.register5,
                                controller: email)),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 1),
                          child:  Row(
                            children: [
                              Text("${AppLocalizations.of(context)!.cmpt} :${ismarchand?
                              AppLocalizations.of(context)!.mrchnd: AppLocalizations.of(context)!.devlpeur} ",
                              style: context.textStyle(fontWeight: FontWeight.bold, fontSize: 15,
                                  colour: Colors.black),),
                              Spacer(),
                              Switch(
                                value: ismarchand,
                                onChanged: (value) {
                                  setState(() {
                                    ismarchand = value;
                                  });
                                },
                                activeTrackColor: ColorName.bleu.withValues(
                                    alpha: 0.45),
                                activeThumbColor: ColorName.bleu,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            child: AuthTextformField(
                                suffix: false,
                                next: true,
                                cas: 2,
                                hintext: ismarchand
                                    ? AppLocalizations.of(context)!.cmgn
                                    : AppLocalizations.of(context)!.devlpeur,
                                prefixIcon: Icons.business_outlined,
                                onClick: () {},
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return AppLocalizations.of(context)!.error;
                                  }
                                  return null;
                                },
                                label: ismarchand
                                    ? AppLocalizations.of(context)!.cmgn
                                    : AppLocalizations.of(context)!.devlpeur,
                                controller: company)),

                        /*
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            child:
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
                                controller: password)),
                        */
                        Space.verticale(heigth: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                          child: BigButton(
                            labelText: AppLocalizations.of(context)!.register7,
                            backgroundClr: Theme.of(context).colorScheme.primary,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fixedSized: Size(MediaQuery.of(context).size.width * 0.85, 50),
                            size: 16,
                            circle: AppRadius.sm,
                            buttonSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                            fontWeight: FontWeight.w500,
                            onPressed: () {
                              _inscription(context);
                            },
                          ),
                        ),
                        Space.verticale(heigth: 10),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        //)
    )

    ;

   /*
      GeneralScaffold(
        content: SingleChildScrollView(
          child: Container(
              width: context.screenWidth,
              height: context.screenHeight,
              decoration: const BoxDecoration(
                color: ColorName.webViolet,
              ),
              child: Form(
                key: globaykey,
                child: PageView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => jumpto(index),
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                ),
              )),
        ));
  */
  }


  void _inscription(BuildContext context) async {



    if (globaykey.currentState!.validate()) {
      openDialogBox(context, "", const CustomAlertDialog());

      bool state = await ref
          .read(authviewProvider.notifier)
          .register(
        firstname: nom.text,
        lastname: prenom.text,
        email: email.text,
        country: phoneNumber.dialCode != null
            ? phoneNumber.dialCode?.substring(1) ?? ''
            : "",
        telephone: numero.text, login: pseudo.text,
         company: company.text,
      );

      if (context.mounted) {
        context.pop(); // Toujours fermer la boite de dialogue de chargement
        if (state) {
          context.pushNamed(RoutesNames.Activate);
        }
      }
    }
  }
}

