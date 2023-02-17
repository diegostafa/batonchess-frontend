class GameHttp {
  factory GameHttp() => _singleton;
  GameHttp._internal();
  static final GameHttp _singleton = GameHttp._internal();

  Future<bool> createGame(
    String userId,
  ) async {
    return false;
  }

  Future<bool> joinGame() async {
    return false;
  }

  Future<bool> leaveGame() async {
    return false;
  }

  Future<bool> sendMove() async {
    return false;
  }

  // TODO : createNewGame, joinGame, leaveGame, sendMove
}
