class GameInfo {
  final int gameId;
  final String creatorId;
  final String creatorName;
  final int createdAt;
  final int maxPlayers;
  final int currentPlayers;

  GameInfo({
    required this.gameId,
    required this.creatorId,
    required this.creatorName,
    required this.createdAt,
    required this.maxPlayers,
    required this.currentPlayers,
  });

  factory GameInfo.fromJson(Map<String, dynamic> json) => GameInfo(
        gameId: json["gameId"] as int,
        creatorId: json["creatorId"] as String,
        creatorName: json["creatorName"] as String,
        createdAt: json["createdAt"] as int,
        maxPlayers: json["maxPlayers"] as int,
        currentPlayers: json["currentPlayers"] as int,
      );
}
