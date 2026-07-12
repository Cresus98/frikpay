import 'package:flutter/cupertino.dart';
import 'package:fripay/views/pages/auth/activate_compte.dart';
import 'package:fripay/views/pages/auth/connexion.dart';
import 'package:fripay/views/pages/auth/forgot_password.dart';
import 'package:fripay/views/pages/auth/inscription.dart';
import 'package:fripay/views/pages/home/card_pages/add_card_stepper.dart';
import 'package:fripay/views/pages/home/cards/cards_hub_page.dart';
import 'package:fripay/views/pages/home/encaissement/encaissement_form_page.dart';
import 'package:fripay/views/pages/home/encaissement/encaissement_list_page.dart';
import 'package:fripay/views/pages/home/home.dart';
import 'package:fripay/views/pages/home/payer/payer_form_page.dart';
import 'package:fripay/views/pages/home/payer/payer_hub_page.dart';
import 'package:fripay/views/pages/home/payer/payer_qr_page.dart';
import 'package:fripay/views/pages/home/payer/payer_link_page.dart';
import 'package:fripay/views/pages/home/payer/payer_merchant_page.dart';
import 'package:fripay/views/pages/home/profile/profile.dart';
import 'package:fripay/views/pages/home/retrait_page.dart';
import 'package:fripay/views/pages/home/transactions/transactions_page.dart';
import 'package:fripay/views/pages/splashscreen.dart' show Splashscreen;
import 'package:fripay/views/utils/constantes.dart';
import 'package:go_router/go_router.dart';



final appRoutes = GoRouter(
    initialLocation: "/${RoutesNames.Splasch}",
    //initialLocation: "/${RoutesNames.Activate}",
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
        name: RoutesNames.Activate,
        path: "/${RoutesNames.Activate}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration:
                const Duration(milliseconds: reversetransitive),
            child: const ActivationAccountPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const ActivationAccountPage(),
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
        name: RoutesNames.PayerQR,
        path: "/${RoutesNames.PayerQR}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: const PayerQrPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const PayerQrPage(),
      ),
      GoRoute(
        name: RoutesNames.PayerLink,
        path: "/${RoutesNames.PayerLink}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: const PayerLinkPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const PayerLinkPage(),
      ),
      GoRoute(
        name: RoutesNames.PayerMerchant,
        path: "/${RoutesNames.PayerMerchant}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: const PayerMerchantPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const PayerMerchantPage(),
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
        name: RoutesNames.AddCarteStepper,
        path: "/${RoutesNames.AddCarteStepper}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: const AddCardStepperPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            ),
          );
        },
        builder: (context, state) => const AddCardStepperPage(),
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
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        name: RoutesNames.Transactions,
        path: "/${RoutesNames.Transactions}",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: transitive),
            reverseTransitionDuration: const Duration(milliseconds: reversetransitive),
            child: const TransactionsPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
              child: child,
            ),
          );
        },
        builder: (context, state) => const TransactionsPage(),
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
  static String Retrait = "Retrait";
  static String Profil = "Profil";
  static String AddCarte = "AddCartes";
  static String AddCarteStepper = "AddCarteStepper";
  static String EncaissementForm = "EncaissementForm";
  static String PayerForm = "PayerForm";
  static String Activate = "Activate";
  static String PayerQR = "PayerQR";
  static String PayerLink = "PayerLink";
  static String PayerMerchant = "PayerMerchant";
  static String Transactions = "Transactions";
}
