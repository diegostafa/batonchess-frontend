enum Side { random, white, black }

class GameProps {
  final int maxPlayers;
  final bool playAsWhite;
  //final int minutesPerSide;
  //final int incrementPerMove;

  GameProps({
    required this.maxPlayers,
    required this.playAsWhite,
    //required this.minutesPerSide,
    //required this.incrementPerMove,
  });

  // FIXME
  factory GameProps.fromJson(Map<String, dynamic> json) => GameProps(
        maxPlayers: json["maxPlayers"] as int,
        playAsWhite: json["playAsWhite"] as bool,
        //minutesPerSide: json["minutesPerSide"] as int,
        //incrementPerMove: json["incrementPerMove"] as int,
      );
}
