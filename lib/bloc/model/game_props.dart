enum Side { random, white, black }

class GameProps {
  final int maxPlayers;
  final Side side;
  final int minPerSide;
  final int incrementPerMove;

  GameProps({required this.maxPlayers, required this.side, required this.minPerSide, required this.incrementPerMove});
}
