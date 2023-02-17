enum Side { random, white, black }

class GameProps {
  // ??? : bool trustPlayers
  final int maxPlayers;
  final Side side;
  final int minutesPerSide;
  final int incrementPerMove;

  GameProps({
    required this.maxPlayers,
    required this.side,
    required this.minutesPerSide,
    required this.incrementPerMove,
  });

  // FIXME
  factory GameProps.fromJson(Map<String, dynamic> json) => GameProps(
        maxPlayers: json["maxPlayers"] as int,
        side: json["Side"] as Side,
        minutesPerSide: json["minutesPerSide"] as int,
        incrementPerMove: json["incrementPerMove"] as int,
      );
}
