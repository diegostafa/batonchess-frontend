import 'package:batonchess/bloc/model/chess_game_state.dart';
import 'package:chess/chess.dart' as ch;

const String initialFen =
    "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";

ch.Chess chessControllerFrom(String fen) => ch.Chess.fromFEN(fen);

String? tryExecMove(String fen, dynamic move) {
  final controller = chessControllerFrom(fen);
  return controller.move(move) ? controller.fen : null;
}

ChessGameState gameStateFrom(String fen) {
  final controller = chessControllerFrom(fen);
  if (controller.in_checkmate) {
    return ChessGameState.checkmate;
  } else if (controller.in_stalemate) {
    return ChessGameState.stalemate;
  } else if (controller.in_threefold_repetition) {
    return ChessGameState.threefoldRepetition;
  } else if (controller.insufficient_material) {
    return ChessGameState.insufficientMaterial;
  } else {
    return ChessGameState.normal;
  }
}
