import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'src/presentation/navigation/app_router.dart';
void main() => runApp(const Real8WalletApp());
class Real8WalletApp extends StatelessWidget {
  const Real8WalletApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'REAL8 Wallet',
      theme: ThemeData(primarySwatch: Colors.blue),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter,
    );
  }
}
