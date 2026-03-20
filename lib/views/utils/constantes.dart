
//import 'package:finanfasend/gen/fonts.gen.dart';
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

/// api data


const String frikpayBaseUrl="https://api.friklabel.com/";

const  String header_code = "CODEX@123";
const  String bearer_username = "flutter";
const  String bearer_username_reset = "web";
const  String bearer_password = "dvxhzdbppk-flutter";


/// Files things

const String succes="success";
const String failed="success";

const int transitive=1000;
const int reversetransitive=1000;