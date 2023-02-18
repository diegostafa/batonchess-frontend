import 'package:batonchess/data/model/game_props.dart';
import 'package:batonchess/data/repo/game_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'new_game_event.dart';
part 'new_game_state.dart';

class NewGameBloc extends Bloc<NewGameEvent, NewGameState> {
  GameRepository gameRepo = GameRepository();

  NewGameBloc() : super(GamePropsState()) {
    on<ChangeSideEvent>(changeSideHandler);
    on<ChangeMaxPlayersEvent>(changeMaxPlayersHandler);
    on<SubmitCreateGameEvent>(submitCreateGameHandler);
  }

  Future<void> changeSideHandler(
    ChangeSideEvent e,
    Emitter<NewGameState> emit,
  ) async {
    if (state is GamePropsState) {
      emit((state as GamePropsState).copyWith(playAsWhite: e.index == 0));
    }
  }

  Future<void> changeMaxPlayersHandler(
    ChangeMaxPlayersEvent e,
    Emitter<NewGameState> emit,
  ) async {
    if (state is GamePropsState) {
      emit((state as GamePropsState).copyWith(maxPlayers: e.sliderVal));
    }
  }

  Future<void> submitCreateGameHandler(
    SubmitCreateGameEvent e,
    Emitter<NewGameState> emit,
  ) async {
    if (state is GamePropsState) {
      final s = state as GamePropsState;
      emit(IsCreatingGameState());

      final gameInfo = await gameRepo.createGame(
        NewGameProps(
          maxPlayers: s.maxPlayers,
        ),
      );
      if (gameInfo != null) {
        final gameState =
            await gameRepo.joinGame(gameInfo, playAsWhite: s.playAsWhite);
        emit(SuccessCreateGameState());
      }
    }
  }
}
