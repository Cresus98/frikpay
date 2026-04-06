// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get register => 'Registration';

  @override
  String get register1 => 'Username ';

  @override
  String get register2 => 'Lastname';

  @override
  String get register3 => 'Firstname';

  @override
  String get register4 => 'Phone number';

  @override
  String get register5 => 'Email';

  @override
  String get register6 => 'Create an account';

  @override
  String get register7 => 'Sign up ';

  @override
  String get register8 => 'L’inscription est faite une seule fois vous ne le ferez plus avant de vous connecter';

  @override
  String get login => 'Log in ';

  @override
  String get login1 => 'Login';

  @override
  String get login2 => 'Password ';

  @override
  String get home => 'Profile';

  @override
  String get home1 => 'Welcome,';

  @override
  String get home2 => 'Welcome to the service you need. Make your transactions securely';

  @override
  String get home3 => 'Applications';

  @override
  String get home4 => 'Cards';

  @override
  String get home5 => 'Dev';

  @override
  String get add_card => 'Add Card';

  @override
  String get add_card1 => 'Card number ';

  @override
  String get add_card2 => 'Expiration date';

  @override
  String get error => 'Please fill in';

  @override
  String get y => 'Yes';

  @override
  String get n => 'No';

  @override
  String get cont => 'Continue';

  @override
  String get val => 'Validate';

  @override
  String get suc => 'Success';

  @override
  String get err => 'Error';

  @override
  String get anu => 'Cancel';

  @override
  String get forgotpass => 'Forgot your password? ';

  @override
  String get cmpt => 'Account';

  @override
  String get mrchnd => 'Merchant';

  @override
  String get cmgn => 'Company';

  @override
  String get devlpeur => 'Developper';

  @override
  String get forgot_title => 'Forgot password';

  @override
  String get forgot_hint =>
      'Enter the email linked to your account. Demo mode: no email is sent.';

  @override
  String get forgot_send => 'Send reset link';

  @override
  String get forgot_success_title => 'Request recorded';

  @override
  String get forgot_success_body =>
      'If an account exists for this address, you will receive a reset link (simulated).';

  @override
  String get forgot_back => 'Back to sign in';

  @override
  String get expiry_incomplete => 'Enter 4 digits (MM then YY)';

  @override
  String get expiry_month => 'Invalid month (01–12)';

  @override
  String get expiry_expired => 'Card has expired';

  @override
  String get cards_title => 'My cards';

  @override
  String get cards_subtitle =>
      'Manage your payment methods securely.';

  @override
  String get operations_title => 'Recent activity';

  @override
  String get encaisser => 'Cash in';

  @override
  String get payer => 'Pay';

  @override
  String get txn_amount => 'Amount (FCFA)';

  @override
  String get txn_network => 'Mobile network';

  @override
  String get txn_phone => 'Phone number';

  @override
  String get txn_moov => 'Moov Money';

  @override
  String get txn_mtn => 'MTN Mobile Money';

  @override
  String get txn_demo => 'Demo: no real payment is processed.';

  @override
  String get txn_confirm_encaissement => 'Confirm cash in';

  @override
  String get txn_confirm_paiement => 'Confirm payment';
}
