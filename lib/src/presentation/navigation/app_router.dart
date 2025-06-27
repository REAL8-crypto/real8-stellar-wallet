import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/main_screen.dart';
import '../screens/wallet/wallet_screen.dart';
import '../screens/trustline/trustline_screen.dart';
import '../screens/liquidity/liquidity_pool_screen.dart';
import '../screens/settings/settings_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/wallet',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainScreen(
            location: state.uri.path,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/wallet',
            name: 'wallet',
            builder: (context, state) => const WalletScreen(),
          ),
          GoRoute(
            path: '/trustlines',
            name: 'trustlines',
            builder: (context, state) => const TrustlineScreen(),
          ),
          GoRoute(
            path: '/liquidity',
            name: 'liquidity',
            builder: (context, state) => const LiquidityPoolScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/wallet'),
              child: const Text('Go to Wallet'),
            ),
          ],
        ),
      ),
    ),
  );
}