import "package:batonchess/data/model/chess/make_move_request.dart";
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
    /**
     * final gameState = await gameRepo.join(gameid)
     * if
     *
     */
  }

  Future<void> leaveGameHandler(
    LeaveGameEvent e,
    Emitter<GameControllerState> emit,
  ) async {}

  Future<void> submitMoveHandler(
    SubmitMoveEvent e,
    Emitter<GameControllerState> emit,
  ) async {
    if (state is IdleGameControllerState) {
      final s = state as IdleGameControllerState;
      final u = await userRepo.getUser();

      if (u == null) return;
      //if (s.gameState.userIdTurn != u.id) return;

      final nextFen = chessEngine.execMove(s.gameState.fen, e.move);
      if (nextFen == null) {
        return;
      }

      await gameRepo.sendMove(
        MakeMoveRequest(gameId: s.gameId, userId: u.id, move: e.move),
      );
    }
  }
}
