part of "settings_bloc.dart";

@immutable
abstract class SettingsEvent {}

class ToggleMaterial3Event extends SettingsEvent {}

class ChangeThemeEvent extends SettingsEvent {
  final int themeIndex;

  ChangeThemeEvent(this.themeIndex);
}
