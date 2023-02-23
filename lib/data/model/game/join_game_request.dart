import "package:batonchess/data/model/json_object.dart";

class JoinGameRequest extends JsonObject {
  final int gameId;
  final String userId;
  final String userName;
  final bool playAsWhite;

  JoinGameRequest({
    required this.gameId,
    required this.userId,
    required this.userName,
    required this.playAsWhite,
  });

  @override
  Map<String, dynamic> toJson() => {
        "gameId": gameId,
        "userId": userId,
        "userName": userName,
        "playAsWhite": playAsWhite,
      };
}
