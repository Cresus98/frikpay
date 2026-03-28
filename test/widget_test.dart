import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/views/pages/home/home.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    const pathChannel = MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(pathChannel, (MethodCall call) async {
      if (call.method == 'getApplicationDocumentsDirectory') {
        return '.';
      }
      return null;
    });
    await GetStorage.init();
  });

  testWidgets('Accueil affiche Encaisser et la grille principale', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          locale: const Locale('fr'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Home(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Encaisser'), findsOneWidget);
    expect(find.text('Payer'), findsOneWidget);
    expect(find.text('Cartes'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);
  });
}
