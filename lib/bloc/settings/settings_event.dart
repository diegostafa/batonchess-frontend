part of "settings_bloc.dart";

@immutable
abstract class SettingsEvent {}

class LoadSettingsEvent extends SettingsEvent {}

class ToggleMaterial3Event extends SettingsEvent {}

class ChangeThemeEvent extends SettingsEvent {
  final int themeIndex;

  ChangeThemeEvent(this.themeIndex);
}
