
//import 'package:finanfasend/gen/fonts.gen.dart';
import 'package:fripay/config/env.dart';
import 'package:flutter/material.dart';





// Material
const unscrollableScrollPhysics = NeverScrollableScrollPhysics();
const bouncingScrollPhysics = BouncingScrollPhysics();
const transparent = Color(0x00000000);
const black = Color(0xFF000000);
const white = Color(0xFFFFFFFF);




// Storage
const String tokens="tokens";
const String user="user";
/// Compte développeur sélectionné (id ou identifiant API) — requis pour certaines actions
const String selectedDeveloperAccountKey = "selected_developer_account";
/// Clé d’application active pour le flux « Payer » (fournie par l’API à terme)
const String activeAppPaymentKey = "active_app_payment_key";





// Flags
const hasBeenDeployed = false;

// Sizes
const designHeight = 852;
const designWidth = 393;
const codeLength = 4;

const appDefaultRadius = 8.0;
final appBluePrimaryColor=Colors.blue.shade900;

/// REGEXP
final allow_positiv = RegExp(r'^\d+(\.\d+)?$');
final positive_value_regex=RegExp(r'^\d*\.?\d*$');
final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

/// api data — valeurs lues depuis [Env] (`--dart-define=…` au build).

String get frikpayBaseUrl => Env.frikpayBaseUrl;

String get header_code => Env.headerCode;

String get bearer_username => Env.bearerUsername;

String get bearer_username_reset => Env.bearerUsernameReset;

String get bearer_password => Env.bearerPassword;


/// Files things

const String succes="success";
const String failed="success";

/// Transitions GoRouter : courtes pour une navigation fluide.
const int transitive = 240;
const int reversetransitive = 200;