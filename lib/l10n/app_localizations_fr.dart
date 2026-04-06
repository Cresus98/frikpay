// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get register => 'Inscription';

  @override
  String get register1 => 'Pseudo';

  @override
  String get register2 => 'Nom';

  @override
  String get register3 => 'Prénom(s)';

  @override
  String get register4 => 'Téléphone';

  @override
  String get register5 => 'Email';

  @override
  String get register6 => 'Créer un compte';

  @override
  String get register7 => 'S\'inscrire';

  @override
  String get register8 => 'L’inscription est faite une seule fois vous ne le ferez plus avant de vous connecter';

  @override
  String get login => 'Se connecter';

  @override
  String get login1 => 'Connexion';

  @override
  String get login2 => 'Mot de passe ';

  @override
  String get home => 'Profil';

  @override
  String get home1 => 'Bienvenue,';

  @override
  String get home2 => 'Bienvenue dans le service qu’il vous faut. Faites vos transactions en toute sécurité';

  @override
  String get home3 => 'Applications';

  @override
  String get home4 => 'Cartes';

  @override
  String get home5 => 'Dev';

  @override
  String get add_card => 'Ajouter une carte';

  @override
  String get add_card1 => 'Numéro de la carte';

  @override
  String get add_card2 => 'Date d\'expriration';

  @override
  String get error => 'Veuillez remplir svp';

  @override
  String get y => 'Oui';

  @override
  String get n => 'Non';

  @override
  String get cont => 'Continuer';

  @override
  String get val => 'Valider';

  @override
  String get suc => 'Succès';

  @override
  String get err => 'Erreur';

  @override
  String get anu => 'Annuler';

  @override
  String get forgotpass => 'Mot de passe oublié ? ';

  @override
  String get cmpt => 'Compte';

  @override
  String get mrchnd => 'Marchand';

  @override
  String get cmgn => 'Compagnie';

  @override
  String get devlpeur => 'Développeur';

  @override
  String get forgot_title => 'Mot de passe oublié';

  @override
  String get forgot_hint =>
      'Entrez l’e-mail lié à votre compte. En mode démo, aucun e-mail n’est envoyé.';

  @override
  String get forgot_send => 'Envoyer le lien';

  @override
  String get forgot_success_title => 'Demande enregistrée';

  @override
  String get forgot_success_body =>
      'Si un compte existe pour cette adresse, vous recevrez un lien de réinitialisation (simulation).';

  @override
  String get forgot_back => 'Retour connexion';

  @override
  String get expiry_incomplete => 'Saisissez 4 chiffres (MM puis AA)';

  @override
  String get expiry_month => 'Mois invalide (01 à 12)';

  @override
  String get expiry_expired => 'Carte expirée';

  @override
  String get cards_title => 'Mes cartes';

  @override
  String get cards_subtitle =>
      'Gérez vos moyens de paiement en toute sécurité.';

  @override
  String get operations_title => 'Activité récente';

  @override
  String get encaisser => 'Encaisser';

  @override
  String get payer => 'Payer';

  @override
  String get txn_amount => 'Montant (FCFA)';

  @override
  String get txn_network => 'Réseau mobile';

  @override
  String get txn_phone => 'Numéro de téléphone';

  @override
  String get txn_moov => 'Moov Money';

  @override
  String get txn_mtn => 'MTN Mobile Money';

  @override
  String get txn_demo =>
      'Démonstration : aucun paiement réel n’est effectué.';

  @override
  String get txn_confirm_encaissement => 'Valider l’encaissement';

  @override
  String get txn_confirm_paiement => 'Confirmer le paiement';
}
