import 'package:batonchess/bloc/model/game_props.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'new_game_event.dart';
part 'new_game_state.dart';

class NewGameBloc extends Bloc<NewGameEvent, NewGameState> {
  NewGameBloc() : super(NewGameState()) {
    on<ChangeSideRadioEvent>(changeSideRadioHandler);
    on<ChangeMaxPlayersEvent>(changeMaxPlayersHandler);
    on<ChangeMinutesPerSideEvent>(changeMinutesPerSideHandler);
    on<ChangeSecondsPerMoveEvent>(changeSecondsPerMoveHandler);
    on<SubmitCreateGameEvent>(submitCreateGameHandler);
  }

  Future<void> changeSideRadioHandler(
    ChangeSideRadioEvent e,
    Emitter<NewGameState> emit,
  ) async {
    emit(state.copyWith(side: Side.values[e.index]));
  }

  Future<void> changeMaxPlayersHandler(
    ChangeMaxPlayersEvent e,
    Emitter<NewGameState> emit,
  ) async {}

  Future<void> changeMinutesPerSideHandler(
    ChangeMinutesPerSideEvent e,
    Emitter<NewGameState> emit,
  ) async {
    emit(state.copyWith(minPerSide: e.minutes));
  }

  Future<void> changeSecondsPerMoveHandler(
    ChangeSecondsPerMoveEvent e,
    Emitter<NewGameState> emit,
  ) async {
    emit(state.copyWith(secondsPerMove: e.seconds));
  }

  Future<void> submitCreateGameHandler(
    SubmitCreateGameEvent e,
    Emitter<NewGameState> emit,
  ) async {
    print("submitting${state.side}");
  }
}
