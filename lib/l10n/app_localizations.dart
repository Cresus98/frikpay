import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('tr')
  ];

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get register;

  /// No description provided for @register1.
  ///
  /// In en, this message translates to:
  /// **'Username '**
  String get register1;

  /// No description provided for @register2.
  ///
  /// In en, this message translates to:
  /// **'Lastname'**
  String get register2;

  /// No description provided for @register3.
  ///
  /// In en, this message translates to:
  /// **'Firstname'**
  String get register3;

  /// No description provided for @register4.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get register4;

  /// No description provided for @register5.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get register5;

  /// No description provided for @register6.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get register6;

  /// No description provided for @register7.
  ///
  /// In en, this message translates to:
  /// **'Sign up '**
  String get register7;

  /// No description provided for @register8.
  ///
  /// In en, this message translates to:
  /// **'L’inscription est faite une seule fois vous ne le ferez plus avant de vous connecter'**
  String get register8;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in '**
  String get login;

  /// No description provided for @login1.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login1;

  /// No description provided for @login2.
  ///
  /// In en, this message translates to:
  /// **'Password '**
  String get login2;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get home;

  /// No description provided for @home1.
  ///
  /// In en, this message translates to:
  /// **'Welcome,'**
  String get home1;

  /// No description provided for @home2.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the service you need. Make your transactions securely'**
  String get home2;

  /// No description provided for @home3.
  ///
  /// In en, this message translates to:
  /// **'Cash in'**
  String get home3;

  /// No description provided for @home4.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get home4;

  /// No description provided for @home5.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get home5;

  /// No description provided for @add_card.
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get add_card;

  /// No description provided for @add_card1.
  ///
  /// In en, this message translates to:
  /// **'Card number '**
  String get add_card1;

  /// No description provided for @add_card2.
  ///
  /// In en, this message translates to:
  /// **'Expiration date'**
  String get add_card2;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Please fill in'**
  String get error;

  /// No description provided for @y.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get y;

  /// No description provided for @n.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get n;

  /// No description provided for @cont.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get cont;

  /// No description provided for @val.
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get val;

  /// No description provided for @suc.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get suc;

  /// No description provided for @err.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get err;

  /// No description provided for @anu.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get anu;

  /// No description provided for @forgotpass.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password? '**
  String get forgotpass;

  /// No description provided for @cmpt.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get cmpt;

  /// No description provided for @mrchnd.
  ///
  /// In en, this message translates to:
  /// **'Merchant'**
  String get mrchnd;

  /// No description provided for @cmgn.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get cmgn;

  /// No description provided for @devlpeur.
  ///
  /// In en, this message translates to:
  /// **'Developper'**
  String get devlpeur;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
