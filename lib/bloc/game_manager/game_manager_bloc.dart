import "package:batonchess/data/model/chess/chess_move.dart";
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/repo/game_repository.dart";
import "package:batonchess/data/repo/user_repository.dart";
import "package:batonchess/utils/chess_utils.dart";
import "package:bloc/bloc.dart";
import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart";
import "package:meta/meta.dart";

part "game_manager_event.dart";
part "game_manager_state.dart";

class GameManagerBloc extends Bloc<GameManagerEvent, GameManagerState> {
  final userRepo = UserRepository();
  final gameRepo = GameRepository();
  final chessEngine = ChessEngineAdapter();

  GameManagerBloc({required GameState gameState})
      : super(IdleGameManagerState(gameState: gameState)) {
    on<MakeMoveEvent>(makeMoveHandler);
  }

  Future<void> makeMoveHandler(
    MakeMoveEvent e,
    Emitter<GameManagerState> emit,
  ) async {
    if (state is IdleGameManagerState) {
      final s = state as IdleGameManagerState;
      final u = await userRepo.getUser();

      if (u == null) return;
      if (s.gameState.userIdTurn != u.id) return;

      final nextFen = chessEngine.execMove(s.gameState.fen, e.move);
      if (nextFen == null) return;

      await gameRepo.sendMove(e.move);
    }
  }
}
