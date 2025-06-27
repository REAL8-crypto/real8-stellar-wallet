import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../util/constants.dart';
import 'trustline_bloc.dart';

class TrustlineScreen extends StatefulWidget {
  const TrustlineScreen({super.key});

  @override
  State<TrustlineScreen> createState() => _TrustlineScreenState();
}

class _TrustlineScreenState extends State<TrustlineScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TrustlineBloc>().add(LoadTrustlines());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trustlines'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to add trustline
            },
            tooltip: 'Add Trustline',
          ),
        ],
      ),
      body: BlocBuilder<TrustlineBloc, TrustlineState>(
        builder: (context, state) {
          if (state is TrustlineLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppConstants.primaryColor,
              ),
            );
          }

          if (state is TrustlineError) {
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
                    onPressed: () => context.read<TrustlineBloc>().add(LoadTrustlines()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is TrustlineLoaded) {
            if (state.trustlines.isEmpty) {
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
                          AppIcons.trustline,
                          size: 64,
                          color: AppConstants.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'No Trustlines Yet',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Add trustlines to hold different assets on the Stellar network.',
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
                            // TODO: Navigate to add trustline
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add Trustline'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: AppConstants.screenPadding,
              itemCount: state.trustlines.length,
              itemBuilder: (context, index) {
                final trustline = state.trustlines[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppConstants.primaryColor.withOpacity(0.1),
                      child: const Icon(
                        AppIcons.trustline,
                        color: AppConstants.primaryColor,
                      ),
                    ),
                    title: Text(
                      trustline.assetCode,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Issuer: ${trustline.displayIssuer}',
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) => _handleTrustlineAction(context, value, trustline),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'view',
                          child: Row(
                            children: [
                              Icon(Icons.visibility),
                              SizedBox(width: 8),
                              Text('View Details'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'remove',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Remove', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // TODO: Navigate to trustline details
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

  void _handleTrustlineAction(BuildContext context, String action, trustline) {
    switch (action) {
      case 'view':
        // TODO: Show trustline details
        break;
      case 'remove':
        // TODO: Remove trustline
        break;
    }
  }
}