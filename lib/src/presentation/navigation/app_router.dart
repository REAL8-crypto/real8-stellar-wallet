import 'package:auto_route/auto_route.dart';
import '../screens/wallet/wallet_screen.dart';
import '../screens/trustline/trustline_screen.dart';
import '../screens/liquidity/liquidity_pool_screen.dart';
import '../screens/settings/settings_screen.dart';

part of 'app_router.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: WalletScreen.page, initial: true),
        AutoRoute(page: TrustlineScreen.page, path: '/trustline'),
        AutoRoute(page: LiquidityPoolScreen.page, path: '/liquidity'),
        AutoRoute(page: SettingsScreen.page, path: '/settings'),
      ];
}