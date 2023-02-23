import "package:batonchess/data/model/game/game_info.dart";
import "package:batonchess/data/model/game/join_game_request.dart";
import "package:batonchess/data/repo/game_repository.dart";
import "package:batonchess/data/repo/user_repository.dart";
import "package:bloc/bloc.dart";
import "package:meta/meta.dart";

part "join_game_event.dart";
part "join_game_state.dart";

class JoinGameBloc extends Bloc<JoinGameEvent, JoinGameState> {
  final userRepo = UserRepository();
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
    if (games == null) {
      emit(FailureLoadingGamesState());
      return;
    }

    emit(SuccessLoadingGamesState(games));
  }

  Future<void> submitJoinGameHandler(
    SubmitJoinGameEvent e,
    Emitter<JoinGameState> emit,
  ) async {
    if (e.sideIndex == null) {
      return;
    }
    final u = await userRepo.getUser();
    if (u == null) {
      return;
    }
    emit(
      JoiningGameState(
        gameInfo: e.targetGame,
        joinReq: JoinGameRequest(
          gameId: e.targetGame.gameId,
          userId: u.id,
          userName: u.name,
          playAsWhite: e.sideIndex == 0,
        ),
      ),
    );
  }
}
