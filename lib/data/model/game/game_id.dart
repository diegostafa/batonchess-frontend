class GameId {
  final int id;

  GameId({required this.id});

  factory GameId.fromJson(Map<String, dynamic> json) => GameId(
        id: json["id"] as int,
      );
}
