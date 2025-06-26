import 'package:flutter/material.dart';
import 'package:real8_stellar_wallet/src/presentation/navigation/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'REAL8 Stellar Wallet',
      routerConfig: _appRouter.config(),
    );
  }
}