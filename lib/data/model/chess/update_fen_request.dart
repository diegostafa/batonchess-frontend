import "package:batonchess/data/model/chess/chess_move.dart";
import "package:batonchess/data/model/json_object.dart";
import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart";

class UpdateFenRequest extends JsonObject {
  final int gameId;
  final String userId;
  final String newFen;

  UpdateFenRequest({
    required this.gameId,
    required this.userId,
    required this.newFen,
  });

  @override
  Map<String, dynamic> toJson() =>
      {"gameId": gameId, "userId": userId, "newFen": newFen};
}
