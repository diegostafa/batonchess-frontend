import "package:batonchess/data/model/game/game_info.dart";
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/repo/game_repository.dart";
import "package:bloc/bloc.dart";
import "package:meta/meta.dart";

part "join_game_event.dart";
part "join_game_state.dart";

class JoinGameBloc extends Bloc<JoinGameEvent, JoinGameState> {
  final gameRepo = GameRepository();

  JoinGameBloc() : super(JoinGameInitial()) {
    on<FetchGamesEvent>(fetchGamesHandler);
    on<SubmitJoinGameEvent>(submitJoinGameHandler);
  }

  Future<void> fetchGamesHandler(
    FetchGamesEvent e,
    Emitter<JoinGameState> emit,
  ) async {
    emit(FetchingGamesState());
    final games = await gameRepo.getActiveGames();
    games == null
        ? emit(FailureLoadingGamesState())
        : emit(SuccessLoadingGamesState(games));
  }

  Future<void> submitJoinGameHandler(
    SubmitJoinGameEvent e,
    Emitter<JoinGameState> emit,
  ) async {
    if (e.sideIndex == null) {
      return;
    }

    emit(JoiningGameState());
    final gameState =
        await gameRepo.joinGame(e.targetGame, playAsWhite: e.sideIndex == 0);
    gameState == null
        ? emit(FailureJoiningGameState())
        : emit(SuccessJoiningGameState(gameState));
  }
}
