import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_windowmanager_v2/flutter_windowmanager_v2.dart' show FlutterWindowManagerV2;
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/views/routes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // FLAG_SECURE bloque captures / enregistrement écran (Android). En debug on le
  // désactive pour faciliter maquettes et support ; en release on le garde.
  // if (kReleaseMode) {
  //   await FlutterWindowManagerV2.addFlags(FlutterWindowManagerV2.FLAG_SECURE);
  // }
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const ProviderScope(child:
  MyApp()
    //QrCodeScreen()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp.router
        (
        title: 'FinanfaSend',
        debugShowCheckedModeBanner: false,
        // Libellés métier (Encaisser, Payer, etc.) : français par défaut
        locale: const Locale('fr'),
        supportedLocales: const [
          Locale('fr'),
          Locale('en'),
          Locale('tr'),
        ],
        localizationsDelegates: const [
         // généré par gen-l10n
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: AppTheme.light(),
        routerConfig: appRoutes,
      )

    /*
      MaterialApp(
      title: 'Frikpay',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    )
    */
    ;
  }
}
