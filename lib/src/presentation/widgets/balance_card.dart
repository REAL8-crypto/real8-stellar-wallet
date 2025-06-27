import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/constants.dart';
import '../../l10n/app_localizations.dart';

class BalanceCard extends StatelessWidget {
  final String assetCode;
  final String assetName;
  final String balance;
  final String? issuer;
  final bool isNative;
  final VoidCallback? onTap;
  final bool showFullIssuer;

  const BalanceCard({
    super.key,
    required this.assetCode,
    required this.assetName,
    required this.balance,
    this.issuer,
    this.isNative = false,
    this.onTap,
    this.showFullIssuer = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Card(
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            gradient: isNative
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppConstants.primaryColor,
                      AppConstants.secondaryColor,
                    ],
                  )
                : assetCode == AppConstants.real8AssetCode
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppConstants.accentColor,
                          AppConstants.accentColor.withOpacity(0.8),
                        ],
                      )
                    : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Asset Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _getAssetColor().withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getAssetIcon(),
                      color: _getAssetColor(),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Asset Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              assetCode,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _getTextColor(context),
                              ),
                            ),
                            if (assetCode == AppConstants.real8AssetCode) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'REAL8',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getTextColor(context),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          assetName,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: _getTextColor(context).withOpacity(0.8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Balance
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatBalance(balance),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _getTextColor(context),
                        ),
                      ),
                      Text(
                        assetCode,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getTextColor(context).withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (issuer != null && !isNative) ...[
                const SizedBox(height: 16),
                _buildIssuerSection(context, l10n),
              ],
              if (_hasActions()) ...[
                const SizedBox(height: 16),
                _buildActionButtons(context, l10n),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIssuerSection(BuildContext context, AppLocalizations l10n) {
    final displayIssuer = showFullIssuer 
        ? issuer! 
        : '${issuer!.substring(0, 6)}...${issuer!.substring(issuer!.length - 6)}';
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.account_circle,
            size: 16,
            color: _getTextColor(context).withOpacity(0.7),
          ),
          const SizedBox(width: 8),
          Text(
            l10n.issuer,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: _getTextColor(context).withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              displayIssuer,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: _getTextColor(context),
                fontFamily: 'monospace',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.copy,
              size: 16,
              color: _getTextColor(context).withOpacity(0.7),
            ),
            onPressed: () => _copyToClipboard(context, issuer!),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: [
        if (assetCode == AppConstants.real8AssetCode) ...[
          Expanded(
            child: _buildActionButton(
              context,
              icon: Icons.swap_horiz,
              label: l10n.swap,
              onPressed: () {
                // TODO: Implement swap functionality
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: _buildActionButton(
            context,
            icon: Icons.send,
            label: l10n.send,
            onPressed: () {
              // TODO: Navigate to send screen with asset preselected
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildActionButton(
            context,
            icon: Icons.call_received,
            label: l10n.receive,
            onPressed: () {
              // TODO: Navigate to receive screen with asset preselected
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2),
        foregroundColor: _getTextColor(context),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Color _getAssetColor() {
    if (isNative) return Colors.white;
    if (assetCode == AppConstants.real8AssetCode) return Colors.white;
    return AppConstants.primaryColor;
  }

  Color _getTextColor(BuildContext context) {
    if (isNative || assetCode == AppConstants.real8AssetCode) {
      return Colors.white;
    }
    return Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
  }

  IconData _getAssetIcon() {
    if (isNative) return Icons.star;
    if (assetCode == AppConstants.real8AssetCode) return Icons.real_estate_agent;
    return Icons.token;
  }

  bool _hasActions() {
    return assetCode == AppConstants.real8AssetCode || 
           assetCode == AppConstants.nativeAssetCode;
  }

  String _formatBalance(String balance) {
    try {
      final double amount = double.parse(balance);
      if (amount == 0) return '0.00';
      if (amount < 0.01) return amount.toStringAsFixed(7);
      if (amount < 1) return amount.toStringAsFixed(4);
      if (amount < 1000) return amount.toStringAsFixed(2);
      if (amount < 1000000) return '${(amount / 1000).toStringAsFixed(1)}K';
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } catch (e) {
      return balance;
    }
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.copiedToClipboard),
        duration: const Duration(seconds: 2),
        backgroundColor: AppConstants.successColor,
      ),
    );
  }
}