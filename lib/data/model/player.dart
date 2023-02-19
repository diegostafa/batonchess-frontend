class Player {
  final String id;
  final String name;
  final bool playingAsWhite;

  Player({required this.id, required this.name, required this.playingAsWhite});

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json['id'] as String,
        name: json['name'] as String,
        playingAsWhite: json['playingAsWhite'] as bool,
      );
}
