import 'package:flutter/cupertino.dart';
import 'package:fripay/views/pages/auth/connexion.dart';
import 'package:fripay/views/pages/auth/inscription.dart';
import 'package:fripay/views/pages/home/dev_accounts_page.dart';
import 'package:fripay/views/pages/home/encaissement_page.dart';
import 'package:fripay/views/pages/home/operations_list_page.dart';
import 'package:fripay/views/pages/home/payer_page.dart';
import 'package:fripay/views/pages/home/card_pages/add_card.dart';
import 'package:fripay/views/pages/home/card_pages/make_card.dart' show HomeScreen;
import 'package:fripay/views/pages/home/card_pages/secons_fr.dart';
import 'package:fripay/views/pages/home/home.dart';
import 'package:fripay/views/pages/home/profile.dart';
import 'package:fripay/views/pages/home/retrait_page.dart';
import 'package:fripay/views/pages/splashscreen.dart' show Splashscreen;
import 'package:fripay/views/utils/constantes.dart';
import 'package:go_router/go_router.dart';



final appRoutes = GoRouter(
    initialLocation: "/${RoutesNames.Splasch}",
    //initialLocation:"/${RoutesNames.VerifyCode}",
    routes: [
      GoRoute(
        name: RoutesNames.Splasch,
        path: "/${RoutesNames.Splasch}",
        builder: (context, state) => const Splashscreen(),
      ),


      GoRoute(
        name: RoutesNames.Inscription,
        path: "/${RoutesNames.Inscription}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: const Inscription(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            ),
          );
        },
        builder: (context, state) => const Inscription(),
      ),
      GoRoute(
        name: RoutesNames.Connexion,
        path: "/${RoutesNames.Connexion}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: const Connexion(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            ),
          );
        },
        builder: (context, state) => const Connexion(),
      ),
      GoRoute(
        name: RoutesNames.Home,
        path: "/${RoutesNames.Home}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: const Home(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            ),
          );
        },
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        name: RoutesNames.Retrait,
        path: "/${RoutesNames.Retrait}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: RetraitPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            ),
          );
        },
        builder: (context, state) =>  RetraitPage(),
      ),
      GoRoute(
        name: RoutesNames.AddCarte,
        path: "/${RoutesNames.AddCarte}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: MyCardsPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            ),
          );
        },
        builder: (context, state) =>  MyCardsPage(),
      ),
      GoRoute(
        name: RoutesNames.Home1,
        path: "/${RoutesNames.Home1}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: AddCardPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            ),
          );
        },
        builder: (context, state) =>  AddCardPage(),
      ),
      GoRoute(
        name: RoutesNames.Home2,
        path: "/${RoutesNames.Home2}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            ),
          );
        },
        builder: (context, state) =>  HomeScreen(),
      ),
      GoRoute(
        name: RoutesNames.Profil,
        path: "/${RoutesNames.Profil}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: ProfileScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            ),
          );
        },
        builder: (context, state) =>  ProfileScreen(),
      ),
      GoRoute(
        name: RoutesNames.Encaisser,
        path: "/${RoutesNames.Encaisser}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: const EncaissementPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            ),
          );
        },
        builder: (context, state) => const EncaissementPage(),
      ),
      GoRoute(
        name: RoutesNames.Payer,
        path: "/${RoutesNames.Payer}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: const PayerPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            ),
          );
        },
        builder: (context, state) => const PayerPage(),
      ),
      GoRoute(
        name: RoutesNames.Developpeurs,
        path: "/${RoutesNames.Developpeurs}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: const DevAccountsPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            ),
          );
        },
        builder: (context, state) => const DevAccountsPage(),
      ),
      GoRoute(
        name: RoutesNames.Operations,
        path: "/${RoutesNames.Operations}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: const OperationsListPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            ),
          );
        },
        builder: (context, state) => const OperationsListPage(),
      ),


    ]);




class RoutesNames {
  static String Splasch = "Splash";
  static String Connexion = "Connexion";
  static String Inscription = "Inscription";
  static String Home = "Home";
  static String Home1 = "Home1";
  static String Home2 = "Home2";
  static String Retrait = "Retrait";
  static String Profil = "Profil";
  static String AddCarte = "AddCartes";
  static String Encaisser = "Encaisser";
  static String Payer = "Payer";
  static String Developpeurs = "Developpeurs";
  static String Operations = "Operations";
}
