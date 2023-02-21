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
    final user = await userRepo.getUser();
    return user == null ? null : gameHttp.createGame(props);
  }

  Future<List<GameInfo>?> getActiveGames() async {
    return gameHttp.getActiveGames();
  }

  Future<GameState?> sendMove(MakeMoveRequest makeMoveReq) async {
    final accepted = gameTcp.makeMove(makeMoveReq);
    final newGameState = gameTcp.getGameState(makeMoveReq.gameId);
    return null;
  }

  Future<GameState?> joinGame(JoinGameRequest joinReq) async {
    final user = await userRepo.getUser();
    return null;
    /**
     *
     */
  }
}
