import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart";

class MakeMoveRequest {
  final int gameId;
  final String userId;
  final ShortMove move;

  MakeMoveRequest(
      {required this.gameId, required this.userId, required this.move,});
}
