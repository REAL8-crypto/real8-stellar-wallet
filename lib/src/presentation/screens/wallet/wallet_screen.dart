import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../wallet_bloc.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('REAL8 Wallet')),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletLoaded) {
            return Column(
              children: [
                Text('Public Key: ${state.wallet.publicKey}'),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/trustline'),
                  child: Text('Manage Trustlines'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/liquidity'),
                  child: Text('View Liquidity Pools'),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}