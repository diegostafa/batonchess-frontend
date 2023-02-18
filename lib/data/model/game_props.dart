class NewGameProps {
  final int maxPlayers;

  NewGameProps({
    required this.maxPlayers,
  });

  factory NewGameProps.fromJson(Map<String, dynamic> json) => NewGameProps(
        maxPlayers: json["maxPlayers"] as int,
      );
}
