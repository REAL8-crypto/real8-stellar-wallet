import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'REAL8 Wallet';
  static const String appVersion = '1.0.0';
  
  // Colors
  static const Color primaryColor = Color(0xFF1E88E5);
  static const Color secondaryColor = Color(0xFF42A5F5);
  static const Color accentColor = Color(0xFF66BB6A);
  static const Color errorColor = Color(0xFFE53935);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color successColor = Color(0xFF4CAF50);
  
  // REAL8 Token Info
  static const String real8AssetCode = 'REAL8';
  static const String real8AssetIssuer = 'GBVYYQ7XXRZW6ZCNNCL2X2THNPQ6IM4O47HAA25JTAG7Z3CXJCQ3W4CD';
  static const String real8ExplorerUrl = 'https://stellar.expert/explorer/public/asset/REAL8-GBVYYQ7XXRZW6ZCNNCL2X2THNPQ6IM4O47HAA25JTAG7Z3CXJCQ3W4CD';
  
  // Stellar Network
  static const String stellarPublicNetwork = 'https://horizon.stellar.org';
  static const String stellarTestNetwork = 'https://horizon-testnet.stellar.org';
  static const String stellarNetworkPassphrase = 'Public Global Stellar Network ; September 2015';
  static const String stellarTestNetworkPassphrase = 'Test SDF Network ; September 2015';
  
  // Wallet Configuration
  static const double minimumXlmReserve = 1.0; // Minimum XLM required for account
  static const double baseFee = 0.00001; // Base fee for transactions
  static const int defaultTimeout = 30; // Default timeout in seconds
  
  // UI Constants
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0);
  
  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);
  
  // Storage Keys
  static const String walletMnemonicKey = 'wallet_mnemonic';
  static const String walletAccountIdKey = 'wallet_account_id';
  static const String walletSecretKey = 'wallet_secret';
  static const String isWalletSetupKey = 'is_wallet_setup';
  static const String selectedLanguageKey = 'selected_language';
  static const String biometricEnabledKey = 'biometric_enabled';
  static const String themeModeKey = 'theme_mode';
  
  // Asset Defaults
  static const String nativeAssetCode = 'XLM';
  static const String nativeAssetName = 'Stellar Lumens';
  
  // Feature Flags
  static const bool enableBiometrics = true;
  static const bool enableTestNet = false; // Set to true for testing
  static const bool enableDebugMode = false;
}

class AppIcons {
  static const IconData wallet = Icons.account_balance_wallet;
  static const IconData send = Icons.send;
  static const IconData receive = Icons.call_received;
  static const IconData history = Icons.history;
  static const IconData settings = Icons.settings;
  static const IconData trustline = Icons.link;
  static const IconData liquidity = Icons.waves;
  static const IconData copy = Icons.copy;
  static const IconData qrCode = Icons.qr_code;
  static const IconData visibility = Icons.visibility;
  static const IconData visibilityOff = Icons.visibility_off;
  static const IconData language = Icons.language;
  static const IconData security = Icons.security;
  static const IconData info = Icons.info;
  static const IconData refresh = Icons.refresh;
  static const IconData add = Icons.add;
  static const IconData remove = Icons.remove;
  static const IconData star = Icons.star;
  static const IconData starBorder = Icons.star_border;
}

enum WalletTab {
  wallet,
  trustlines,
  liquidity,
  settings,
}

enum TransactionType {
  sent,
  received,
  trustlineAdded,
  trustlineRemoved,
  liquidityAdded,
  liquidityRemoved,
}

enum NetworkType {
  testnet,
  mainnet,
}