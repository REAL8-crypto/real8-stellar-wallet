import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SettingsEvent {}
class SwitchLanguageEvent extends SettingsEvent {
  final String languageCode;
  SwitchLanguageEvent(this.languageCode);
}

class SettingsState {
  final String languageCode;
  SettingsState(this.languageCode);
}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState('en')) {
    on<SwitchLanguageEvent>((event, emit) {
      emit(SettingsState(event.languageCode));
    });
  }
}