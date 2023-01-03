import 'package:batonchess/bloc/model/game_props.dart';
import 'package:batonchess/data/repo/game_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'new_game_event.dart';
part 'new_game_state.dart';

class NewGameBloc extends Bloc<NewGameEvent, NewGameState> {
  GameRepository gameRepo = GameRepository();

  NewGameBloc() : super(GamePropsState()) {
    on<ChangeSideRadioEvent>(changeSideRadioHandler);
    on<ChangeMaxPlayersRadioEvent>(changeMaxPlayersRadioHandler);
    on<ChangeMinutesPerSideEvent>(changeMinutesPerSideHandler);
    on<ChangeSecondsPerMoveEvent>(changeSecondsPerMoveHandler);
    on<SubmitCreateGameEvent>(submitCreateGameHandler);
  }

  Future<void> changeSideRadioHandler(
    ChangeSideRadioEvent e,
    Emitter<NewGameState> emit,
  ) async {
    if (state is GamePropsState) {
      emit((state as GamePropsState).copyWith(side: Side.values[e.index]));
    }
  }

  Future<void> changeMaxPlayersRadioHandler(
    ChangeMaxPlayersRadioEvent e,
    Emitter<NewGameState> emit,
  ) async {
    if (state is GamePropsState) {
      // todo : think about maxplayers
      final Map<int, int> mockMap = {0: 1, 1: 5, 2: 1};
      emit((state as GamePropsState).copyWith(maxPlayers: mockMap[e.index]));
    }
  }

  Future<void> changeMinutesPerSideHandler(
    ChangeMinutesPerSideEvent e,
    Emitter<NewGameState> emit,
  ) async {
    if (state is GamePropsState) {
      emit((state as GamePropsState).copyWith(minPerSide: e.minutes));
    }
  }

  Future<void> changeSecondsPerMoveHandler(
    ChangeSecondsPerMoveEvent e,
    Emitter<NewGameState> emit,
  ) async {
    if (state is GamePropsState) {
      emit((state as GamePropsState).copyWith(incPerMove: e.seconds));
    }
  }

  Future<void> submitCreateGameHandler(
    SubmitCreateGameEvent e,
    Emitter<NewGameState> emit,
  ) async {
    if (state is GamePropsState) {
      // todo : validation
      final s = state as GamePropsState;
      emit(IsCreatingGameState());
      final game = await gameRepo.createNewGame(
        GameProps(
          side: s.side,
          minutesPerSide: s.minPerSide,
          incrementPerMove: s.incPerMove,
          maxPlayers: s.maxPlayers,
        ),
      );
      emit(SuccessCreateGameState());
    }
  }
}
