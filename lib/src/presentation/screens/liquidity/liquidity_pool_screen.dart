import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../liquidity_pool_bloc.dart';

class LiquidityPoolScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('REAL8 Liquidity Pools')),
      body: BlocBuilder<LiquidityPoolBloc, LiquidityPoolState>(
        builder: (context, state) {
          if (state is LiquidityPoolLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LiquidityPoolLoaded) {
            return ListView.builder(
              itemCount: state.pools.length,
              itemBuilder: (context, index) {
                final pool = state.pools[index];
                return ListTile(
                  title: Text('Pool ID: ${pool.id}'),
                  subtitle: Text('Total Shares: ${pool.totalShares}'),
                );
              },
            );
          } else if (state is LiquidityPoolError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}