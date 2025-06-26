import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Wallet Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.router.pushNamed('/trustline');
              },
              child: const Text('Go to Trustline'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.router.pushNamed('/liquidity');
              },
              child: const Text('Go to Liquidity Pool'),
            ),
          ],
        ),
      ),
    );
  }
}