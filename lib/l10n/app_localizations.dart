import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

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
/// Make sure to add the following to your `pubspec.yaml` file:
///
/// ```yaml
/// dependencies:
///   flutter:
///     sdk: flutter
///   flutter_localizations:
///     sdk: flutter
///   intl: any
/// ```
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
    Locale('es')
  ];

  /// App title
  String get appTitle;

  /// Wallet
  String get wallet;

  /// Trustlines
  String get trustlines;

  /// Liquidity
  String get liquidity;

  /// Settings
  String get settings;

  /// Quick Actions
  String get quickActions;

  /// Send
  String get send;

  /// Receive
  String get receive;

  /// Scan
  String get scan;

  /// Add Trustline
  String get addTrustline;

  /// Add Liquidity
  String get addLiquidity;

  /// History
  String get history;

  /// Balance
  String get balance;

  /// Recent Transactions
  String get recentTransactions;

  /// View All
  String get viewAll;

  /// No transactions yet
  String get noTransactionsYet;

  /// Your transactions will appear here
  String get transactionsWillAppearHere;

  /// Welcome to REAL8
  String get welcomeToReal8;

  /// Create or import a wallet to get started with REAL8 tokens on the Stellar network
  String get getStartedDescription;

  /// Create Wallet
  String get createWallet;

  /// Import Wallet
  String get importWallet;

  /// Loading wallet...
  String get loadingWallet;

  /// Refresh
  String get refresh;

  /// Receive Payment
  String get receivePayment;

  /// Backup Wallet
  String get backupWallet;

  /// Export Keys
  String get exportKeys;

  /// View on Explorer
  String get viewOnExplorer;

  /// Oops! Something went wrong
  String get oopsError;

  /// Retry
  String get retry;

  /// Loading...
  String get loading;

  /// Load More
  String get loadMore;

  /// Sent to
  String get sentTo;

  /// Received from
  String get receivedFrom;

  /// Trustline Added
  String get trustlineAdded;

  /// Trustline Removed
  String get trustlineRemoved;

  /// Liquidity Added
  String get liquidityAdded;

  /// Liquidity Removed
  String get liquidityRemoved;

  /// Unknown Address
  String get unknownAddress;

  /// Copied to clipboard
  String get copiedToClipboard;

  /// Issuer
  String get issuer;

  /// Swap
  String get swap;

  /// Language
  String get language;

  /// Theme
  String get theme;

  /// Biometrics
  String get biometrics;

  /// Security
  String get security;

  /// Network
  String get network;

  /// About
  String get about;

  /// Support
  String get support;

  /// English
  String get english;

  /// Español
  String get spanish;

  /// Light
  String get light;

  /// Dark
  String get dark;

  /// System
  String get system;

  /// Enabled
  String get enabled;

  /// Disabled
  String get disabled;

  /// Mainnet
  String get mainnet;

  /// Testnet
  String get testnet;

  /// Version
  String get version;

  /// Contact Support
  String get contactSupport;

  /// Privacy Policy
  String get privacyPolicy;

  /// Terms of Service
  String get termsOfService;

  /// OK
  String get ok;

  /// Cancel
  String get cancel;

  /// Confirm
  String get confirm;

  /// Delete
  String get delete;

  /// Edit
  String get edit;

  /// Save
  String get save;

  /// Close
  String get close;

  /// Done
  String get done;

  /// Next
  String get next;

  /// Previous
  String get previous;

  /// Skip
  String get skip;

  /// Continue
  String get continueAction;

  /// Yes
  String get yes;

  /// No
  String get no;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue on GitHub with a '
    'reproducible example app and the exact error message you are seeing here: '
    'https://github.com/flutter/flutter/issues/new?template=2_bug.md'
  );
}