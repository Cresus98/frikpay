import 'package:flutter/material.dart';
import 'package:fripay/views/routes.dart' show RoutesNames;
import 'package:fripay/views/utils/extensions.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/init.dart' show interne_storage;
import '../../gen/assets.gen.dart';
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
    final cs = Theme.of(context).colorScheme;
    return GeneralScaffold(
      content: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              cs.primary,
              cs.primary.withValues(alpha: 0.92),
              Theme.of(context).scaffoldBackgroundColor,
            ],
            stops: const [0.0, 0.42, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: cs.onPrimary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Assets.images.logoFripaySvg.svg(height: 56, width: 56, fit: BoxFit.cover),
              ),
            ),
            Space.verticale(heigth: context.dy(16)),
            Text(
              'FinanfaSend',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: cs.onPrimary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
            ),
            Space.verticale(heigth: context.dy(8)),
            Text(
              'Paiements mobiles sécurisés',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cs.onPrimary.withValues(alpha: 0.88),
                  ),
            ),
            Space.verticale(heigth: context.dy(36)),
            SizedBox(
              height: context.dy(44),
              width: context.dx(44),
              child: CircularProgressIndicator(
                color: cs.onPrimary,
                strokeWidth: 3,
                backgroundColor: cs.onPrimary.withValues(alpha: 0.2),
              ),
            ),
          ],
        ),
      ),
    )

    ;
  }

  Future<void> loadPage() async {
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    if (interne_storage.read(tokens) == null) {
      context.goNamed(RoutesNames.Connexion);
      return;
    }

    context.goNamed(RoutesNames.Home);



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
