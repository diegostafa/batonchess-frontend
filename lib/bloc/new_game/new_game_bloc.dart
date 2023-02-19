import 'package:batonchess/data/model/game_props.dart';
import 'package:batonchess/data/model/game_state.dart';
import 'package:batonchess/data/repo/game_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'new_game_event.dart';
part 'new_game_state.dart';

class NewGameBloc extends Bloc<NewGameEvent, NewGameState> {
  GameRepository gameRepo = GameRepository();

  NewGameBloc() : super(SettingGamePropsState()) {
    on<ChangeSideEvent>(changeSideHandler);
    on<ChangeMaxPlayersEvent>(changeMaxPlayersHandler);
    on<SubmitCreateGameEvent>(submitCreateGameHandler);
  }

  Future<void> changeSideHandler(
    ChangeSideEvent e,
    Emitter<NewGameState> emit,
  ) async {
    if (state is SettingGamePropsState) {
      emit(
          (state as SettingGamePropsState).copyWith(playAsWhite: e.index == 0),);
    }
  }

  Future<void> changeMaxPlayersHandler(
    ChangeMaxPlayersEvent e,
    Emitter<NewGameState> emit,
  ) async {
    if (state is SettingGamePropsState) {
      emit((state as SettingGamePropsState).copyWith(maxPlayers: e.sliderVal));
    }
  }

  Future<void> submitCreateGameHandler(
    SubmitCreateGameEvent e,
    Emitter<NewGameState> emit,
  ) async {
    if (state is SettingGamePropsState) {
      final s = state as SettingGamePropsState;
      emit(CreatingGameState());

      final gameInfo = await gameRepo.createGame(
        NewGameProps(
          maxPlayers: s.maxPlayers,
        ),
      );

      if (gameInfo != null) {
        print("GOT GAME INFO CREATOR IS: ${gameInfo.creatorName}");
        final gameState =
            await gameRepo.joinGame(gameInfo, playAsWhite: s.playAsWhite);
        gameState == null
            ? emit(FailureCreatingGameState())
            : emit(SuccessCreatingGameState(gameState));
      }
    }
  }
}
