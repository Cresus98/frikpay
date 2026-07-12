import 'package:flutter/material.dart';

// ─── Material Constants ─────────────────────────────────────────────────────
const unscrollableScrollPhysics = NeverScrollableScrollPhysics();
const bouncingScrollPhysics = BouncingScrollPhysics();
const transparent = Color(0x00000000);
const black = Color(0xFF000000);
const white = Color(0xFFFFFFFF);

const lang = "lang";

// ─── Storage Keys ───────────────────────────────────────────────────────────
const String tokens = "token";
const String user = "user";
const String selectedDeveloperAccountKey = "selected_developer_account";
const String activeAppPaymentKey = "active_app_payment_key";

// ─── Flags ──────────────────────────────────────────────────────────────────
const hasBeenDeployed = false;

// ─── Design Sizes ───────────────────────────────────────────────────────────
const designHeight = 852;
const designWidth = 393;
const codeLength = 4;

const appDefaultRadius = 8.0;
const appBluePrimaryColor = Color(0xFF2196F3);

// ─── Regexp ─────────────────────────────────────────────────────────────────
final allow_positiv = RegExp(r'^\d+(\.\d+)?$');
final positive_value_regex = RegExp(r'^\d*\.?\d*$');
final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

// ─── API Status Constants ───────────────────────────────────────────────────
// API endpoints & credentials are in lib/config/api_config.dart
const String succes = "success";
const String failed = "failed";

// ─── Transitions ────────────────────────────────────────────────────────────
const int transitive = 240;
const int reversetransitive = 200;

const String appName = "FrikPay";
