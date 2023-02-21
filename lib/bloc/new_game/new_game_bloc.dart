import "package:batonchess/data/model/game/create_game_request.dart";
import "package:batonchess/data/model/game/game_info.dart";
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/repo/game_repository.dart";
import "package:batonchess/data/repo/user_repository.dart";
import "package:bloc/bloc.dart";
import "package:meta/meta.dart";

part "new_game_event.dart";
part "new_game_state.dart";

class NewGameBloc extends Bloc<NewGameEvent, NewGameState> {
  final userRepo = UserRepository();
  final gameRepo = GameRepository();

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
        (state as SettingGamePropsState).copyWith(playAsWhite: e.index == 0),
      );
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
      final user = await userRepo.getUser();
      if (user == null) {
        emit(FailureCreatingGameState());
        return;
      }

      final gameInfo = await gameRepo.createGame(
        CreateGameRequest(
          creatorId: user.id,
          maxPlayers: s.maxPlayers,
        ),
      );

      if (gameInfo == null) {
        emit(FailureCreatingGameState());
        return;
      }

      final gameState =
          await gameRepo.joinGame(gameInfo, playAsWhite: s.playAsWhite);
      if (gameState == null) {
        emit(FailureJoiningGameState());
        return;
      }

      emit(SuccessCreatingGameState(
          joinedGameState: gameState, joinedGameInfo: gameInfo));
    }
  }
}
