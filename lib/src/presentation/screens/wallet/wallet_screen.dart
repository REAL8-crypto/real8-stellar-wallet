import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';
import '../../../util/constants.dart';
import 'wallet_bloc.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(LoadWallet());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.wallet),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<WalletBloc>().add(RefreshWallet()),
            tooltip: l10n.refresh,
          ),
        ],
      ),
      body: BlocConsumer<WalletBloc, WalletState>(
        listener: (context, state) {
          if (state is WalletError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppConstants.errorColor,
              ),
            );
          } else if (state is WalletActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppConstants.successColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is WalletInitial || (state is WalletLoading && state.isInitialLoad)) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: AppConstants.primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(l10n.loadingWallet),
                ],
              ),
            );
          }

          if (state is WalletError) {
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
                    onPressed: () => context.read<WalletBloc>().add(LoadWallet()),
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            );
          }

          if (state is WalletNotFound) {
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
                        AppIcons.wallet,
                        size: 64,
                        color: AppConstants.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.welcomeToReal8,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.getStartedDescription,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Navigate to create wallet
                        },
                        icon: const Icon(Icons.add),
                        label: Text(l10n.createWallet),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Navigate to import wallet
                        },
                        icon: const Icon(Icons.download),
                        label: Text(l10n.importWallet),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is WalletLoaded) {
            return SingleChildScrollView(
              padding: AppConstants.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Balance Section
                  _buildBalanceSection(context, state, l10n),
                  const SizedBox(height: 24),
                  // Quick Actions
                  _buildQuickActionsSection(context, l10n),
                  const SizedBox(height: 24),
                  // Recent Transactions
                  _buildTransactionsSection(context, state, l10n),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBalanceSection(BuildContext context, WalletLoaded state, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.balance,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildBalanceRow(context, 'XLM', state.wallet?.xlmBalance ?? '0'),
                const Divider(),
                _buildBalanceRow(context, 'REAL8', state.wallet?.real8Balance ?? '0'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceRow(BuildContext context, String asset, String balance) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          asset,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          balance,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.quickActions,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                context,
                icon: AppIcons.send,
                label: l10n.send,
                onTap: () {
                  // TODO: Navigate to send
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                context,
                icon: AppIcons.receive,
                label: l10n.receive,
                onTap: () {
                  // TODO: Navigate to receive
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                context,
                icon: AppIcons.qrCode,
                label: l10n.scan,
                onTap: () {
                  // TODO: Navigate to scan
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(
                icon,
                color: AppConstants.primaryColor,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsSection(BuildContext context, WalletLoaded state, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.recentTransactions,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to full history
              },
              child: Text(l10n.viewAll),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (state.transactions.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(
                    AppIcons.history,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noTransactionsYet,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.transactionsWillAppearHere,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        else
          ...state.transactions.take(5).map((transaction) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppConstants.primaryColor.withOpacity(0.1),
                child: Icon(
                  transaction.isIncoming ? Icons.arrow_downward : Icons.arrow_upward,
                  color: transaction.isIncoming ? AppConstants.successColor : AppConstants.errorColor,
                ),
              ),
              title: Text(
                transaction.isIncoming ? l10n.receivedFrom : l10n.sentTo,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(transaction.displayAddress),
              trailing: Text(
                '${transaction.isIncoming ? '+' : '-'}${transaction.displayAmount} ${transaction.displayAsset}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: transaction.isIncoming ? AppConstants.successColor : AppConstants.errorColor,
                ),
              ),
            ),
          )),
      ],
    );
  }
}