import "package:batonchess/data/model/game/game_info.dart";

class JoinGameRequest {
  final GameInfo gameInfo;
  final bool playAsWhite;

  JoinGameRequest({
    required this.gameInfo,
    required this.playAsWhite,
  });

  Map<String, dynamic> toJson() => {
        "gameInfo": gameInfo,
        "playAsWhite": playAsWhite,
      };
}
