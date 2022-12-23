class GameProps {
  final Side _playAs = Side.Random;
  final Visibility _vis = Visibility.Global;
  final GameMode _gm = GameMode();
}

enum Side {
  Random,
  White,
  Black
}

enum Visibility {
  Local,
  Global
}

class GameMode {
  final int minPerSide = 0;
  final int secPerMove = 0;
}
