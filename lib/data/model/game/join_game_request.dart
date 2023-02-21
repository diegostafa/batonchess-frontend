class JoinGameRequest {
  final String userId;
  final int gameId;
  final bool playAsWhite;

  JoinGameRequest(
      {required this.userId, required this.gameId, required this.playAsWhite,});

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "gameId": gameId,
        "playAsWhite": playAsWhite,
      };
}
