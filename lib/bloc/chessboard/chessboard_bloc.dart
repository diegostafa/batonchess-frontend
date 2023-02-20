import 'package:batonchess/data/model/chess_game_state.dart';
import 'package:batonchess/utils/chess_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_stateless_chessboard/types.dart';
import 'package:meta/meta.dart';

part 'chessboard_event.dart';
part 'chessboard_state.dart';

class ChessboardBloc extends Bloc<ChessboardEvent, ChessboardState> {
  ChessboardBloc() : super(NormalChessboardState()) {
    on<MakeMoveEvent>(makeMoveHandler);
  }

  Future<void> makeMoveHandler(
    MakeMoveEvent e,
    Emitter<ChessboardState> emit,
  ) async {
    if (state is NormalChessboardState) {
      final state = this.state as NormalChessboardState;

      final newFen = tryExecMove(state.fen, {
        'from': e.move.from,
        'to': e.move.to,
        'promotion': 'q',
      });

      if (newFen != null) {
        final gameState = gameStateFrom(newFen);
        if (gameState == ChessGameState.normal) {
          emit(state.copyWith(fen: newFen));
        } else {
          emit(FinalChessboardState(
              finalFen: newFen, finalGameState: gameState));
        }
        /**
         * repo.broadCast(newfen)
         * <backend calculates next player>
         *
         */
      }
    }
  }
}
