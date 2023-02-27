class UserPlayer {
  final String id;
  final String name;
  final bool playingAsWhite;

  UserPlayer({
    required this.id,
    required this.name,
    required this.playingAsWhite,
  });

  factory UserPlayer.fromJson(Map<String, dynamic> json) => UserPlayer(
        id: json["id"] as String,
        name: json["name"] as String,
        playingAsWhite: json["playingAsWhite"] as bool,
      );

  static List<UserPlayer> fromJsonList(dynamic list) {
    if (list == null) {
      return [];
    }
    return (list as List<dynamic>)
        .map((e) => UserPlayer.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
