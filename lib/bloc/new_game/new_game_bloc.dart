import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'new_game_event.dart';
part 'new_game_state.dart';

class NewGameBloc extends Bloc<NewGameEvent, NewGameState> {
  NewGameBloc() : super(NewGameState()) {
    on<ChangeSideRadioEvent>(changeSideRadioHandler);
    on<ChangeVisibilityRadioEvent>(changeVisibilityRadioHandler);
    on<ChangeTimeFormatRadioEvent>(changeTimeFormatRadioHandler);
    on<SubmitCreateGameEvent>(submitCreateGameHandler);
  }

  Future<void> changeSideRadioHandler(
      ChangeSideRadioEvent e, Emitter<NewGameState> emit,) async {}

  Future<void> changeVisibilityRadioHandler(
      ChangeVisibilityRadioEvent e, Emitter<NewGameState> emit,) async {}

  Future<void> changeTimeFormatRadioHandler(
      ChangeTimeFormatRadioEvent e, Emitter<NewGameState> emit,) async {}

  Future<void> submitCreateGameHandler(
      SubmitCreateGameEvent e, Emitter<NewGameState> emit,) async {}
}
