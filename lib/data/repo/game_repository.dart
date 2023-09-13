import "package:batonchess/data/dao/http/game_http.dart";
import "package:batonchess/data/dao/tcp/game_tcp.dart";
import "package:batonchess/data/model/chess/update_fen_request.dart";
import "package:batonchess/data/model/game/create_game_request.dart";
import "package:batonchess/data/model/game/game_info.dart";
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/model/game/join_game_request.dart";
import "package:batonchess/data/repo/user_repository.dart";

class GameRepository {
  final gameTcp = GameTcp();
  final gameHttp = GameHttp();
  final userRepo = UserRepository();

  Future<GameInfo?> createGame(CreateGameRequest props) async =>
      gameHttp.createGame(props);

  Future<List<GameInfo>?> getActiveGames() async => gameHttp.getActiveGames();

  Stream<GameState?> joinGame(JoinGameRequest joinReq) =>
      gameTcp.joinGame(joinReq);

  Future<void> sendMove(UpdateFenRequest updateReq) =>
      gameTcp.updateFen(updateReq);

  Future<void> setupGameTcp() async => gameTcp.connect();

  Future<void> leaveGame() async => gameTcp.leaveGame();
}
