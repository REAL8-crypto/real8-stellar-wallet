import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/constants.dart';

// Settings Events
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class ChangeLanguage extends SettingsEvent {
  final Locale locale;

  const ChangeLanguage(this.locale);

  @override
  List<Object?> get props => [locale];
}

class ChangeTheme extends SettingsEvent {
  final ThemeMode themeMode;

  const ChangeTheme(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class ToggleBiometrics extends SettingsEvent {
  final bool enabled;

  const ToggleBiometrics(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class UpdateNetworkType extends SettingsEvent {
  final NetworkType networkType;

  const UpdateNetworkType(this.networkType);

  @override
  List<Object?> get props => [networkType];
}

// Settings States
abstract class SettingsState extends Equatable {
  final Locale locale;
  final ThemeMode themeMode;
  final bool biometricEnabled;
  final NetworkType networkType;

  const SettingsState({
    required this.locale,
    required this.themeMode,
    required this.biometricEnabled,
    required this.networkType,
  });

  @override
  List<Object?> get props => [locale, themeMode, biometricEnabled, networkType];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial()
      : super(
          locale: const Locale('en'),
          themeMode: ThemeMode.system,
          biometricEnabled: false,
          networkType: NetworkType.mainnet,
        );
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({
    required super.locale,
    required super.themeMode,
    required super.biometricEnabled,
    required super.networkType,
  });

  SettingsLoaded copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    bool? biometricEnabled,
    NetworkType? networkType,
  }) {
    return SettingsLoaded(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      networkType: networkType ?? this.networkType,
    );
  }
}

// Settings Bloc
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const String _languageKey = 'language_code';
  static const String _themeModeKey = 'theme_mode';
  static const String _biometricKey = 'biometric_enabled';
  static const String _networkTypeKey = 'network_type';

  SettingsBloc() : super(const SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<ChangeLanguage>(_onChangeLanguage);
    on<ChangeTheme>(_onChangeTheme);
    on<ToggleBiometrics>(_onToggleBiometrics);
    on<UpdateNetworkType>(_onUpdateNetworkType);
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load language
      final languageCode = prefs.getString(_languageKey) ?? 'en';
      final locale = Locale(languageCode);
      
      // Load theme mode
      final themeModeIndex = prefs.getInt(_themeModeKey) ?? 0;
      final themeMode = ThemeMode.values[themeModeIndex];
      
      // Load biometric setting
      final biometricEnabled = prefs.getBool(_biometricKey) ?? false;
      
      // Load network type
      final networkTypeIndex = prefs.getInt(_networkTypeKey) ?? 1; // Default to mainnet
      final networkType = NetworkType.values[networkTypeIndex];
      
      emit(SettingsLoaded(
        locale: locale,
        themeMode: themeMode,
        biometricEnabled: biometricEnabled,
        networkType: networkType,
      ));
    } catch (e) {
      emit(const SettingsLoaded(
        locale: Locale('en'),
        themeMode: ThemeMode.system,
        biometricEnabled: false,
        networkType: NetworkType.mainnet,
      ));
    }
  }

  Future<void> _onChangeLanguage(
    ChangeLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, event.locale.languageCode);
      
      if (state is SettingsLoaded) {
        emit((state as SettingsLoaded).copyWith(locale: event.locale));
      }
    } catch (e) {
      // Handle error silently for now
    }
  }

  Future<void> _onChangeTheme(
    ChangeTheme event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeModeKey, event.themeMode.index);
      
      if (state is SettingsLoaded) {
        emit((state as SettingsLoaded).copyWith(themeMode: event.themeMode));
      }
    } catch (e) {
      // Handle error silently for now
    }
  }

  Future<void> _onToggleBiometrics(
    ToggleBiometrics event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_biometricKey, event.enabled);
      
      if (state is SettingsLoaded) {
        emit((state as SettingsLoaded).copyWith(biometricEnabled: event.enabled));
      }
    } catch (e) {
      // Handle error silently for now
    }
  }

  Future<void> _onUpdateNetworkType(
    UpdateNetworkType event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_networkTypeKey, event.networkType.index);
      
      if (state is SettingsLoaded) {
        emit((state as SettingsLoaded).copyWith(networkType: event.networkType));
      }
    } catch (e) {
      // Handle error silently for now
    }
  }
}