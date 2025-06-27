import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util/constants.dart';
import 'liquidity_pool_bloc.dart';

class LiquidityPoolScreen extends StatefulWidget {
  const LiquidityPoolScreen({super.key});

  @override
  State<LiquidityPoolScreen> createState() => _LiquidityPoolScreenState();
}

class _LiquidityPoolScreenState extends State<LiquidityPoolScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LiquidityPoolBloc>().add(LoadLiquidityPools());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liquidity Pools'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<LiquidityPoolBloc>().add(RefreshLiquidityPools()),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocBuilder<LiquidityPoolBloc, LiquidityPoolState>(
        builder: (context, state) {
          if (state is LiquidityPoolLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppConstants.primaryColor,
              ),
            );
          }

          if (state is LiquidityPoolError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppConstants.errorColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.read<LiquidityPoolBloc>().add(LoadLiquidityPools()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is LiquidityPoolLoaded) {
            if (state.pools.isEmpty) {
              return Center(
                child: Padding(
                  padding: AppConstants.screenPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppConstants.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          AppIcons.liquidity,
                          size: 64,
                          color: AppConstants.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'No Liquidity Pools Found',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Liquidity pools will appear here when available.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: AppConstants.screenPadding,
              itemCount: state.pools.length,
              itemBuilder: (context, index) {
                final pool = state.pools[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppConstants.accentColor.withOpacity(0.1),
                      child: const Icon(
                        AppIcons.liquidity,
                        color: AppConstants.accentColor,
                      ),
                    ),
                    title: Text(
                      pool.displayName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pool ID: ${pool.displayId}'),
                        Text('Total Shares: ${pool.totalShares}'),
                        Text('Fee: ${pool.feePercentage.toStringAsFixed(2)}%'),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // TODO: Navigate to pool details
                    },
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}