import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Trigger SwitchLanguageUseCase for 'en'
            context.read<SettingsBloc>().add(SwitchLanguageEvent('en'));
          },
          child: Image.asset('assets/images/en_flag.png', width: 32),
        ),
        SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            // Trigger SwitchLanguageUseCase for 'es'
            context.read<SettingsBloc>().add(SwitchLanguageEvent('es'));
          },
          child: Image.asset('assets/images/es_flag.png', width: 32),
        ),
      ],
    );
  }
}