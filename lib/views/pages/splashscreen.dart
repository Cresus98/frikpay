import 'package:flutter/material.dart';
import 'package:fripay/views/routes.dart' show RoutesNames;
import 'package:fripay/views/utils/extensions.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:go_router/go_router.dart';
import '';
import '../../controllers/init.dart' show interne_storage;
import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../utils/constantes.dart';
import '../utils/globalwidget/space.dart';



class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}


class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
      content: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        color: ColorName.webwhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.images.logoFripaySvg.svg(height: 70, width: 70,fit: BoxFit.cover),

            Space.verticale(heigth: context.dy(10)),
            Text("FrikPay",style: context.textStyle(
              colour: Colors.black,fontSize: 25,fontWeight: FontWeight.w900
            ),),
            Space.verticale(heigth: context.dy(30)),
            Container(
              alignment: Alignment.center,
              height: context.dy(45),
              width: context.dx(45),
              child: const CircularProgressIndicator(
                color: ColorName.bleu,
                backgroundColor: ColorName.webwhite,
              ),
            ),
          ],
        ),
      ),
    )

    ;
  }

  Future<void> loadPage() async {
    await Future.delayed(const Duration(milliseconds: 5000));

    if(interne_storage.read(tokens)== null) {
      // Future(() => context.goNamed(RoutesNames.Connexion));
      Future(() => context.goNamed(RoutesNames.Connexion));
      return;
    }

    Future(() => context.goNamed(RoutesNames.Home));



    /*
    else if (interne_storage.read(StringData.client) != null) {
      user_controller.set_user();
      Future(() => Get.offAll(() =>
      //const Connexion()));
      const HomePage()));

      //const Payement()));
    }
    else {
      Future(() => context.goNamed(RoutesNames.Presentation));
    }
    */
  }

}
