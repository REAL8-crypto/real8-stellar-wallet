import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../util/constants.dart';
import '../settings_bloc.dart';

class MainScreen extends StatefulWidget {
  final String location;
  final Widget child;

  const MainScreen({
    super.key,
    required this.location,
    required this.child,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _getCurrentIndex() {
    final String location = widget.location;
    if (location.startsWith('/wallet')) return 0;
    if (location.startsWith('/trustlines')) return 1;
    if (location.startsWith('/liquidity')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 0;
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.go('/wallet');
        break;
      case 1:
        context.go('/trustlines');
        break;
      case 2:
        context.go('/liquidity');
        break;
      case 3:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentIndex = _getCurrentIndex();
    
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        return Scaffold(
          body: widget.child,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      context,
                      index: 0,
                      icon: AppIcons.wallet,
                      label: l10n.wallet,
                      isSelected: currentIndex == 0,
                    ),
                    _buildNavItem(
                      context,
                      index: 1,
                      icon: AppIcons.trustline,
                      label: l10n.trustlines,
                      isSelected: currentIndex == 1,
                    ),
                    _buildNavItem(
                      context,
                      index: 2,
                      icon: AppIcons.liquidity,
                      label: l10n.liquidity,
                      isSelected: currentIndex == 2,
                    ),
                    _buildNavItem(
                      context,
                      index: 3,
                      icon: AppIcons.settings,
                      label: l10n.settings,
                      isSelected: currentIndex == 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: currentIndex == 0
              ? FloatingActionButton.extended(
                  onPressed: () => _showQuickActions(context),
                  backgroundColor: AppConstants.primaryColor,
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.bolt),
                  label: Text(l10n.quickActions),
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: AppConstants.fastAnimationDuration,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppConstants.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: AppConstants.fastAnimationDuration,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppConstants.primaryColor
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).iconTheme.color,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? AppConstants.primaryColor
                    : Theme.of(context).textTheme.bodySmall?.color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickActions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.quickActions,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickActionItem(
                  context,
                  icon: AppIcons.send,
                  label: l10n.send,
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to send
                  },
                ),
                _buildQuickActionItem(
                  context,
                  icon: AppIcons.receive,
                  label: l10n.receive,
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to receive
                  },
                ),
                _buildQuickActionItem(
                  context,
                  icon: AppIcons.qrCode,
                  label: l10n.scan,
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to scan
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickActionItem(
                  context,
                  icon: AppIcons.trustline,
                  label: l10n.addTrustline,
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/trustlines');
                  },
                ),
                _buildQuickActionItem(
                  context,
                  icon: AppIcons.liquidity,
                  label: l10n.addLiquidity,
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/liquidity');
                  },
                ),
                _buildQuickActionItem(
                  context,
                  icon: AppIcons.history,
                  label: l10n.history,
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to history
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppConstants.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppConstants.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}