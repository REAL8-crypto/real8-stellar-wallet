import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/model/transaction.dart';
import '../../util/constants.dart';
import '../../l10n/app_localizations.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(Transaction)? onTransactionTap;
  final bool showLoadMore;
  final VoidCallback? onLoadMore;
  final bool isLoading;

  const TransactionList({
    super.key,
    required this.transactions,
    this.onTransactionTap,
    this.showLoadMore = false,
    this.onLoadMore,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty && !isLoading) {
      return _buildEmptyState(context);
    }

    return Column(
      children: [
        ...transactions.map((transaction) => TransactionListItem(
          transaction: transaction,
          onTap: onTransactionTap != null
              ? () => onTransactionTap!(transaction)
              : null,
        )),
        if (showLoadMore && onLoadMore != null) ...[
          const SizedBox(height: 16),
          _buildLoadMoreButton(context),
        ],
        if (isLoading) ...[
          const SizedBox(height: 16),
          const Center(
            child: CircularProgressIndicator(
              color: AppConstants.primaryColor,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            AppIcons.history,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noTransactionsYet,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
    );
  }

  Widget _buildLoadMoreButton(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Center(
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : onLoadMore,
        icon: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppConstants.primaryColor,
                ),
              )
            : const Icon(Icons.expand_more),
        label: Text(isLoading ? l10n.loading : l10n.loadMore),
      ),
    );
  }
}

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;

  const TransactionListItem({
    super.key,
    required this.transaction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Transaction Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getTransactionColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getTransactionIcon(),
                  color: _getTransactionColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // Transaction Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _getTransactionTitle(l10n),
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          _formatAmount(),
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _getAmountColor(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _getTransactionSubtitle(l10n),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          _formatDate(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Status Indicator
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _getStatusColor(),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getTransactionIcon() {
    switch (transaction.type) {
      case TransactionType.sent:
        return Icons.arrow_upward;
      case TransactionType.received:
        return Icons.arrow_downward;
      case TransactionType.trustlineAdded:
        return Icons.link;
      case TransactionType.trustlineRemoved:
        return Icons.link_off;
      case TransactionType.liquidityAdded:
        return Icons.add_circle;
      case TransactionType.liquidityRemoved:
        return Icons.remove_circle;
    }
  }

  Color _getTransactionColor() {
    switch (transaction.type) {
      case TransactionType.sent:
        return AppConstants.errorColor;
      case TransactionType.received:
        return AppConstants.successColor;
      case TransactionType.trustlineAdded:
        return AppConstants.primaryColor;
      case TransactionType.trustlineRemoved:
        return AppConstants.warningColor;
      case TransactionType.liquidityAdded:
        return AppConstants.accentColor;
      case TransactionType.liquidityRemoved:
        return AppConstants.warningColor;
    }
  }

  Color _getAmountColor() {
    switch (transaction.type) {
      case TransactionType.sent:
        return AppConstants.errorColor;
      case TransactionType.received:
        return AppConstants.successColor;
      default:
        return Colors.grey.shade700;
    }
  }

  Color _getStatusColor() {
    switch (transaction.status) {
      case 'success':
        return AppConstants.successColor;
      case 'pending':
        return AppConstants.warningColor;
      case 'failed':
        return AppConstants.errorColor;
      default:
        return Colors.grey.shade400;
    }
  }

  String _getTransactionTitle(AppLocalizations l10n) {
    switch (transaction.type) {
      case TransactionType.sent:
        return l10n.sentTo;
      case TransactionType.received:
        return l10n.receivedFrom;
      case TransactionType.trustlineAdded:
        return l10n.trustlineAdded;
      case TransactionType.trustlineRemoved:
        return l10n.trustlineRemoved;
      case TransactionType.liquidityAdded:
        return l10n.liquidityAdded;
      case TransactionType.liquidityRemoved:
        return l10n.liquidityRemoved;
    }
  }

  String _getTransactionSubtitle(AppLocalizations l10n) {
    if (transaction.type == TransactionType.sent || 
        transaction.type == TransactionType.received) {
      final address = transaction.type == TransactionType.sent
          ? transaction.toAddress
          : transaction.fromAddress;
      if (address != null && address.length > 12) {
        return '${address.substring(0, 6)}...${address.substring(address.length - 6)}';
      }
      return address ?? l10n.unknownAddress;
    }
    
    return transaction.memo ?? transaction.assetCode ?? '';
  }

  String _formatAmount() {
    if (transaction.amount == null) return '';
    
    final amount = double.tryParse(transaction.amount!) ?? 0.0;
    final prefix = transaction.type == TransactionType.sent ? '-' : '+';
    final formattedAmount = _formatBalance(amount.abs());
    
    if (transaction.type == TransactionType.sent || 
        transaction.type == TransactionType.received) {
      return '$prefix$formattedAmount ${transaction.assetCode ?? 'XLM'}';
    }
    
    return '${transaction.assetCode ?? ''}';
  }

  String _formatBalance(double amount) {
    if (amount == 0) return '0.00';
    if (amount < 0.01) return amount.toStringAsFixed(7);
    if (amount < 1) return amount.toStringAsFixed(4);
    if (amount < 1000) return amount.toStringAsFixed(2);
    if (amount < 1000000) return '${(amount / 1000).toStringAsFixed(1)}K';
    return '${(amount / 1000000).toStringAsFixed(1)}M';
  }

  String _formatDate() {
    try {
      final date = DateTime.parse(transaction.createdAt);
      final now = DateTime.now();
      final difference = now.difference(date);
      
      if (difference.inDays == 0) {
        return DateFormat.Hm().format(date);
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return DateFormat.E().format(date);
      } else {
        return DateFormat.MMMd().format(date);
      }
    } catch (e) {
      return transaction.createdAt;
    }
  }
}