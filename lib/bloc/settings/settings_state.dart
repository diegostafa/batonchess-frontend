part of "settings_bloc.dart";

@immutable
class SettingsState {
  final BatonchessSettings settings;

  const SettingsState({
    this.settings = const BatonchessSettings(useMaterial3: true, themeIndex: 0),
  });
}
