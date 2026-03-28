import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/views/utils/constantes.dart';
import 'package:fripay/views/utils/extensions.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:go_router/go_router.dart';

import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart' show ColorName;
import '../../../l10n/app_localizations.dart';
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
  TextEditingController id_controller = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isChecked = false;
  bool obscure = true;
  int selected = 0;
  final globaykey = GlobalKey<FormState>();


  @override
  void dispose() {
    id_controller.dispose();
    password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return
      GeneralScaffold(
        content: SingleChildScrollView(
          child: Container(
            width: context.screenWidth,
            height: context.screenHeight,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Form(
              key: globaykey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.logoFripaySvg.svg(height: 70, width: 70,fit: BoxFit.cover),
                  Space.verticale(heigth:15),
                  Text(
                    'FinanfaSend',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
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
                          hintext: "Login",
                          //AppLocalizations.of(context)!.register1,
                          onClick: () {
                          },
                          validator:(value) {
                            if(value!.isEmpty)
                            {
                              return AppLocalizations.of(context)!.error;
                            }
                            return null;
                          },
                          label: "Login",
                          //AppLocalizations.of(context)!.register1,
                          controller: id_controller)),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      child:
                      AuthTextformField(
                          suffix: true,
                          next: false,
                          cas: 2,
                          hintext: AppLocalizations.of(context)!.login2,
                          onClick: () {
                            obscure = !obscure;
                            setState(() {});
                          },
                          obscure: obscure,
                          input_type: TextInputType.text,
                          onChanged: (p0) {
                            if(globaykey.currentState!.validate())
                            {
                              _seconnecter(context);
                            }

                          },
                          iconData: obscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          label: AppLocalizations.of(context)!.login2,
                          validator: (value) {
                            if(value!.isEmpty)
                            {
                              return "";
                            }
                            return null;
                          },
                          controller: password)),
                  Space.verticale(heigth: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(),
                        RichText(
                          text: TextSpan(
                              text: AppLocalizations.of(context)!.forgotpass,
                              style: context.textStyle(
                                  colour: ColorName.bleu,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 11),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //context.pushNamed(RoutesNames.Resset,
                                  //  extra: 2);
                                }),
                        ),
                      ],
                    ),
                  ),
                  Space.verticale(heigth: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    child: BigButton(
                      labelText:  AppLocalizations.of(context)!.login,
                      backgroundClr:  ColorName.bleu,
                      color:ColorName.webwhite,
                      fixedSized: Size(350, 48),
                      size: 17,
                      circle: 4,
                      buttonSide: const BorderSide(
                        color: ColorName.bleu,
                        width: 1,
                      ),
                      fontWeight: FontWeight.w500,
                      onPressed: () {
                        _seconnecter(context);
                        // context.goNamed(RoutesNames.Home);
                      },
                    ),
                  ),
                  Space.verticale(heigth: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    child: BigButton(
                      labelText: AppLocalizations.of(context)!.register6,
                      backgroundClr: ColorName.webwhite,
                      color:ColorName.bleu,
                      fixedSized: Size(350, 48),
                      size: 17,
                      circle: 4,
                      buttonSide: const BorderSide(
                        color: ColorName.bleu,
                        width: 1,
                      ),
                      fontWeight: FontWeight.w500,
                      onPressed: () {
                        print("press it ");
                        context.pushNamed(RoutesNames.Inscription);
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }

  void _seconnecter(BuildContext context) async{

    if (globaykey.currentState!.validate()) {

      openDialogBox(context,"",const CustomAlertDialog());
     // print("les valeurs sont ${id_controller.text.replaceAll('', '')}");
      bool state=true;
      //await ref
        //  .read(authviewProvider.notifier)

          //.login(id_controller.text.replaceAll(' ', ''), password.text.replaceAll(' ', ''), "7", "6");


      if(state)
      {
        context.pop();
        context.goNamed(RoutesNames.Home);
      }
      //else
      //{
      //context.pop();
      //}

      //
    }

  }

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
  }
}
