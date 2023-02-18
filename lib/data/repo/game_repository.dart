import 'package:batonchess/data/dao/game/game_http.dart';
import 'package:batonchess/data/dao/user/user_cache.dart';
import 'package:batonchess/data/model/game_props.dart';
import 'package:batonchess/data/model/game_state.dart';
import 'package:batonchess/data/model/move.dart';

class GameRepository {
  final gameHttp = GameHttp();
  final userCache = UserCache();

  Future<GameState?> createGame(GameProps props) async {
    final gameId = await gameHttp.createGame(userCache.user!.id, props);

    return (gameId != null)
        ? GameState(
            gameId: gameId,
            fen: "",
            status: "",
            props: props,
            whiteTeam: [],
            blackTeam: [])
        : null;
  }

  Future<List<GameState>?> getActiveGames() async {
    final res = await gameHttp.getActiveGames();
    return res;
  }

  Future<void> makeMove(Move move) async {
    print("sending a move");
  }
}
