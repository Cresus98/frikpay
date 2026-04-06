import 'package:flutter/cupertino.dart';
import 'package:fripay/views/pages/auth/connexion.dart';
import 'package:fripay/views/pages/auth/forgot_password.dart';
import 'package:fripay/views/pages/auth/inscription.dart';
import 'package:fripay/views/pages/home/applications_list.dart';
import 'package:fripay/views/pages/home/card_pages/add_card.dart';
import 'package:fripay/views/pages/home/card_pages/secons_fr.dart';
import 'package:fripay/views/pages/home/cards/cards_hub_page.dart';
import 'package:fripay/views/pages/home/encaissement/encaissement_form_page.dart';
import 'package:fripay/views/pages/home/encaissement/encaissement_list_page.dart';
import 'package:fripay/views/pages/home/home.dart';
import 'package:fripay/views/pages/home/payer/payer_form_page.dart';
import 'package:fripay/views/pages/home/payer/payer_hub_page.dart';
import 'package:fripay/views/pages/home/profile.dart';
import 'package:fripay/views/pages/home/profile/dev_accounts_page.dart';
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
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
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
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const Connexion(),
      ),
      GoRoute(
        name: RoutesNames.ForgotPassword,
        path: "/${RoutesNames.ForgotPassword}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration:
                const Duration(milliseconds: reversetransitive),
            child: const ForgotPasswordPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const ForgotPasswordPage(),
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
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        name: RoutesNames.Encaisser,
        path: "/${RoutesNames.Encaisser}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration:
                const Duration(milliseconds: reversetransitive),
            child: const EncaissementListPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurvedAnimation(
                  parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const EncaissementListPage(),
      ),
      GoRoute(
        name: RoutesNames.EncaissementForm,
        path: "/${RoutesNames.EncaissementForm}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration:
                const Duration(milliseconds: reversetransitive),
            child: const EncaissementFormPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurvedAnimation(
                  parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const EncaissementFormPage(),
      ),
      GoRoute(
        name: RoutesNames.Payer,
        path: "/${RoutesNames.Payer}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration:
                const Duration(milliseconds: reversetransitive),
            child: const PayerHubPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurvedAnimation(
                  parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const PayerHubPage(),
      ),
      GoRoute(
        name: RoutesNames.PayerForm,
        path: "/${RoutesNames.PayerForm}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration:
                const Duration(milliseconds: reversetransitive),
            child: const PayerFormPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurvedAnimation(
                  parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const PayerFormPage(),
      ),
      GoRoute(
        name: RoutesNames.Retrait,
        path: "/${RoutesNames.Retrait}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: const RetraitPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const RetraitPage(),
      ),
      GoRoute(
        name: RoutesNames.AddCarte,
        path: "/${RoutesNames.AddCarte}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: const CardsHubPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const CardsHubPage(),
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
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
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
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
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
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) =>  ProfileScreen(),
      ),
      GoRoute(
        name: RoutesNames.Applications,
        path: "/${RoutesNames.Applications}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: AnimatedListPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) =>  AnimatedListPage(),
      ),
      GoRoute(
        name: RoutesNames.DevAccounts,
        path: "/${RoutesNames.DevAccounts}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration:
                const Duration(milliseconds: reversetransitive),
            child: const DevAccountsPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurvedAnimation(
                  parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const DevAccountsPage(),
      ),
    ]);




class RoutesNames {
  static String Splasch = "Splash";
  static String Connexion = "Connexion";
  static String ForgotPassword = "ForgotPassword";
  static String Inscription = "Inscription";
  static String Home = "Home";
  static String Encaisser = "Encaissement";
  static String Payer = "Paiement";
  static String Home1 = "Home1";
  static String Home2 = "Home2";
  static String Retrait = "Retrait";
  static String Profil = "Profil";
  static String AddCarte = "AddCartes";
  static String Applications = "Applications";
  static String Developpeurs = "Developpeurs";
  static String EncaissementForm = "EncaissementForm";
  static String PayerForm = "PayerForm";
  static String DevAccounts = "DevAccounts";
}
