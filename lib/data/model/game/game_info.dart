class GameInfo {
  final int gameId;
  final String creatorName;
  final String gameStatus;
  final String createdAt;
  final int maxPlayers;
  final int currentPlayers;

  GameInfo({
    required this.gameId,
    required this.creatorName,
    required this.gameStatus,
    required this.createdAt,
    required this.maxPlayers,
    required this.currentPlayers,
  });

  factory GameInfo.fromJson(Map<String, dynamic> json) => GameInfo(
        gameId: json["gameId"] as int,
        creatorName: json["creatorName"] as String,
        gameStatus: json["gameStatus"] as String,
        createdAt: json["createdAt"] as String,
        maxPlayers: json["maxPlayers"] as int,
        currentPlayers: json["currentPlayers"] as int,
      );
}
