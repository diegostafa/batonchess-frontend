import "package:flutter_stateless_chessboard/types.dart";

extension ChessMove on ShortMove {
  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "promotion": "q",
      };
}
