import "package:batonchess/data/model/chess/make_move_request.dart";
import "package:batonchess/data/model/game/game_id.dart";
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/model/game/join_game_request.dart";
import "package:batonchess/data/repo/game_repository.dart";
import "package:batonchess/data/repo/user_repository.dart";
import "package:batonchess/utils/chess_utils.dart";
import "package:bloc/bloc.dart";
import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart";
import "package:meta/meta.dart";

part "game_controller_event.dart";
part "game_controller_state.dart";

class GameControllerBloc
    extends Bloc<GameControllerEvent, GameControllerState> {
  final userRepo = UserRepository();
  final gameRepo = GameRepository();
  final chessEngine = ChessEngineAdapter();

  GameControllerBloc() : super(InitialGameControllerState()) {
    on<JoinGameEvent>(joinGameHandler);
    on<LeaveGameEvent>(leaveGameHandler);
    on<SubmitMoveEvent>(submitMoveHandler);
  }

  Future<void> joinGameHandler(
    JoinGameEvent e,
    Emitter<GameControllerState> emit,
  ) async {
    emit(JoiningGameControllerState());

    final gameState = await gameRepo.joinGame(e.joinReq);
    if (gameState == null) {
      emit(FailureJoiningGameControllerState());
      return;
    }

    emit(ReadyGameControllerState(
        gameId: GameId(id: e.joinReq.gameId), gameState: gameState,),);
  }

  Future<void> leaveGameHandler(
    LeaveGameEvent e,
    Emitter<GameControllerState> emit,
  ) async {}

  Future<void> submitMoveHandler(
    SubmitMoveEvent e,
    Emitter<GameControllerState> emit,
  ) async {
    if (state is ReadyGameControllerState) {
      final s = state as ReadyGameControllerState;
      final u = await userRepo.getUser();

      if (u == null) return;
      //if (s.gameState.userIdTurn != u.id) return;

      final nextFen = chessEngine.execMove(s.gameState.fen, e.move);
      if (nextFen == null) {
        return;
      }

      await gameRepo.sendMove(
        MakeMoveRequest(gameId: s.gameId.id, userId: u.id, move: e.move),
      );
    }
  }
}
