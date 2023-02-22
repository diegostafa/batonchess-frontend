import "package:batonchess/data/dao/http/game_http.dart";
import "package:batonchess/data/dao/tcp/game_tcp.dart";
import "package:batonchess/data/model/chess/make_move_request.dart";
import "package:batonchess/data/model/game/create_game_request.dart";
import "package:batonchess/data/model/game/game_info.dart";
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/model/game/join_game_request.dart";
import "package:batonchess/data/repo/user_repository.dart";

class Move {}

class GameRepository {
  final gameTcp = GameTcp();
  final gameHttp = GameHttp();
  final userRepo = UserRepository();

  Future<GameInfo?> createGame(CreateGameRequest props) async {
    return gameHttp.createGame(props);
  }

  Future<List<GameInfo>?> getActiveGames() async {
    return gameHttp.getActiveGames();
  }

  Future<GameState?> sendMove(MakeMoveRequest makeMoveReq) async {
    return gameTcp.makeMove(makeMoveReq);
  }

  Future<GameState?> joinGame(JoinGameRequest joinReq) async {
    final gameState = gameTcp.joinGame(joinReq);
  }
}
