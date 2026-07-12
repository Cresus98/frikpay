import 'dart:convert';

import 'env.dart';

/// Centralised API configuration — all endpoints and credentials
/// are read from [Env] (--dart-define at build time).
abstract final class ApiConfig {
  ApiConfig._();

  // ─── Base URL ─────────────────────────────────────────────────────────────
  static String get baseUrl => Env.frikpayBaseUrl;

  // ─── Auth endpoints ───────────────────────────────────────────────────────
  static const String login = 'auth/v1/user/login';
  static const String register = 'auth/v1/user/register';
  static const String activation = 'auth/v1/user/activation';
  static const String resetPassword = 'auth/v1/user/reset';

  // ─── Card endpoints ───────────────────────────────────────────────────────
  static const String cardCreate = 'v1/card/create';
  static const String cardLoad = 'v1/card/load';
  static const String cardWithdrawalInit = 'v1/card/withdrawalInit';
  static const String cardWithdrawalValidate = 'v1/card/withdrawalSet';
  static const String cardTransferInit = 'v1/card/TransferToCardInit';
  static const String cardTransferValidate = 'v1/card/TransferToCardSet';
  static const String cardTransactions = 'v1/card/TransactionsList';
  static const String cardInfos = 'v1/card/infos';
  static const String cardPci = 'v1/card/cardPCIData';
  static const String cardBalance = 'v1/card/balance';
  static const String cardActivate = 'v1/card/activation';
  static const String cardDeactivate = 'v1/card/desactivation';

  // ─── Developer account endpoints ──────────────────────────────────────────
  static const String accountList = 'v1/account/list';
  static const String accountAdd = 'v1/account/add';

  // ─── Auth helpers ─────────────────────────────────────────────────────────
  static String get basicAuthHeader {
    final username = Env.bearerUsername;
    final password = Env.bearerPassword;
    return 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  }

  static String get basicAuthHeaderReset {
    final username = Env.bearerUsernameReset;
    final password = Env.bearerPassword;
    return 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  }
}
