import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart";

extension ChessMove on ShortMove {
  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "promotion": promotion.name,
      };
}
