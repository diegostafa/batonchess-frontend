import "package:batonchess/data/model/chess/chess_move.dart";
import "package:chess/chess.dart";
import "package:flutter_stateless_chessboard/types.dart";

class ChessEngineAdapter {
  Chess chessControllerFrom(String fen) => Chess.fromFEN(fen);

  String? execMove(String fen, ShortMove move) {
    final ctrl = chessControllerFrom(fen);
    if (ctrl.move(move.toJson()) == false) {
      return null;
    }

    return ctrl.fen;
  }
}
