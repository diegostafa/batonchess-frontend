import "package:batonchess/data/dao/memory/settings_memory.dart";
import "package:batonchess/data/model/batonchess_settings.dart";
import "package:bloc/bloc.dart";
import "package:meta/meta.dart";

part "settings_event.dart";
part "settings_state.dart";

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final sm = SettingsMemory();

  SettingsBloc() : super(const SettingsState()) {
    on<ToggleMaterial3Event>(toggleMaterial3Handler);
    on<ChangeThemeEvent>(changeThemeHandler);
  }

  Future<void> toggleMaterial3Handler(
    ToggleMaterial3Event e,
    Emitter<SettingsState> emit,
  ) async {
    emit(
      SettingsState(
        settings:
            state.settings.copyWith(useMaterial3: !state.settings.useMaterial3),
      ),
    );
  }

  Future<void> changeThemeHandler(
    ChangeThemeEvent e,
    Emitter<SettingsState> emit,
  ) async {
    emit(
      SettingsState(
        settings: state.settings.copyWith(themeIndex: e.themeIndex),
      ),
    );
  }
}
