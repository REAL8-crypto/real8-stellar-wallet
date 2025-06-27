import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util/constants.dart';
import '../../settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: AppConstants.screenPadding,
            children: [
              const SizedBox(height: 16),
              _buildSection(
                context,
                title: 'General',
                children: [
                  _buildLanguageSelector(context, state),
                  _buildThemeSelector(context, state),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: 'Security',
                children: [
                  _buildBiometricSwitch(context, state),
                  _buildNetworkSelector(context, state),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: 'About',
                children: [
                  _buildAboutItem(context, 'Version', AppConstants.appVersion),
                  _buildAboutItem(context, 'Support', 'Contact Support'),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildLanguageSelector(BuildContext context, SettingsState state) {
    return ListTile(
      leading: const Icon(AppIcons.language),
      title: const Text('Language'),
      subtitle: Text(state.locale.languageCode == 'en' ? 'English' : 'Español'),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => _showLanguageDialog(context),
    );
  }

  Widget _buildThemeSelector(BuildContext context, SettingsState state) {
    String themeText;
    switch (state.themeMode) {
      case ThemeMode.light:
        themeText = 'Light';
        break;
      case ThemeMode.dark:
        themeText = 'Dark';
        break;
      case ThemeMode.system:
        themeText = 'System';
        break;
    }

    return ListTile(
      leading: const Icon(Icons.brightness_6),
      title: const Text('Theme'),
      subtitle: Text(themeText),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => _showThemeDialog(context),
    );
  }

  Widget _buildBiometricSwitch(BuildContext context, SettingsState state) {
    return SwitchListTile(
      secondary: const Icon(AppIcons.security),
      title: const Text('Biometric Authentication'),
      subtitle: const Text('Use fingerprint or face unlock'),
      value: state.biometricEnabled,
      activeColor: AppConstants.primaryColor,
      onChanged: (value) {
        context.read<SettingsBloc>().add(ToggleBiometrics(value));
      },
    );
  }

  Widget _buildNetworkSelector(BuildContext context, SettingsState state) {
    return ListTile(
      leading: const Icon(Icons.network_check),
      title: const Text('Network'),
      subtitle: Text(state.networkType == NetworkType.mainnet ? 'Mainnet' : 'Testnet'),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => _showNetworkDialog(context),
    );
  }

  Widget _buildAboutItem(BuildContext context, String title, String value) {
    return ListTile(
      leading: const Icon(AppIcons.info),
      title: Text(title),
      subtitle: Text(value),
      onTap: title == 'Support' ? () {
        // TODO: Open support
      } : null,
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              onTap: () {
                context.read<SettingsBloc>().add(const ChangeLanguage(Locale('en')));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Español'),
              onTap: () {
                context.read<SettingsBloc>().add(const ChangeLanguage(Locale('es')));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Light'),
              onTap: () {
                context.read<SettingsBloc>().add(const ChangeTheme(ThemeMode.light));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Dark'),
              onTap: () {
                context.read<SettingsBloc>().add(const ChangeTheme(ThemeMode.dark));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('System'),
              onTap: () {
                context.read<SettingsBloc>().add(const ChangeTheme(ThemeMode.system));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showNetworkDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Network'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Mainnet'),
              subtitle: const Text('Live Stellar network'),
              onTap: () {
                context.read<SettingsBloc>().add(const UpdateNetworkType(NetworkType.mainnet));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Testnet'),
              subtitle: const Text('Test Stellar network'),
              onTap: () {
                context.read<SettingsBloc>().add(const UpdateNetworkType(NetworkType.testnet));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}