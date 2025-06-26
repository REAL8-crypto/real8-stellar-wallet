import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

// Import your screens with explicit paths
import 'package:real8_stellar_wallet/src/presentation/screens/main_screen.dart';
import 'package:real8_stellar_wallet/src/presentation/screens/wallet/wallet_screen.dart';
import 'package:real8_stellar_wallet/src/presentation/screens/trustline/trustline_screen.dart';
import 'package:real8_stellar_wallet/src/presentation/screens/liquidity/liquidity_pool_screen.dart';
import 'package:real8_stellar_wallet/src/presentation/screens/settings/settings_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MainRoute.page, path: '/', initial: true),
    AutoRoute(page: WalletRoute.page, path: '/wallet'),
    AutoRoute(page: TrustlineRoute.page, path: '/trustline'),
    AutoRoute(page: LiquidityPoolRoute.page, path: '/liquidity'),
    AutoRoute(page: SettingsRoute.page, path: '/settings'),
  ];
}