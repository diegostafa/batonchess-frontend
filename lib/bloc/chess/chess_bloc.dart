import 'package:batonchess/data/model/chess_game_state.dart';
import 'package:batonchess/utils/chess_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_stateless_chessboard/types.dart';
import 'package:meta/meta.dart';

part 'chess_event.dart';
part 'chess_state.dart';

class ChessBloc extends Bloc<ChessEvent, ChessState> {
  ChessBloc() : super(NormalChessState()) {
    on<MakeMoveEvent>(makeMoveHandler);
  }

  Future<void> makeMoveHandler(
    MakeMoveEvent e,
    Emitter<ChessState> emit,
  ) async {
    if (state is NormalChessState) {
      final state = this.state as NormalChessState;

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
          emit(FinalChessState(finalFen: newFen, finalGameState: gameState));
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
