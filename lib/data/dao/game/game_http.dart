

class GameHttp {
  factory GameHttp() => _singleton;
  GameHttp._internal();
  static final GameHttp _singleton = GameHttp._internal();

  // TODO : createNewGame, joinGame, leaveGame, sendMove
}
