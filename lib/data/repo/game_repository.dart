import 'package:batonchess/data/dao/http/game_http.dart';
import 'package:batonchess/data/model/game/create_game_request.dart';
import 'package:batonchess/data/model/game/game_info.dart';
import 'package:batonchess/data/model/game/game_state.dart';
import 'package:batonchess/data/model/game/join_game_request.dart';
import 'package:batonchess/data/repo/user_repository.dart';

class Move {}

class GameRepository {
  final gameHttp = GameHttp();
  final userRepo = UserRepository();

  Future<GameInfo?> createGame(CreateGameRequest props) async {
    final user = await userRepo.getUser();
    return user == null ? null : gameHttp.createGame(props);
  }

  Future<List<GameInfo>?> getActiveGames() async {
    return gameHttp.getActiveGames();
  }

  Future<void> makeMove(Move move) async {
    print("sending a move");
  }

  Future<GameState?> joinGame(
    GameInfo gameInfo, {
    required bool playAsWhite,
  }) async {
    final user = await userRepo.getUser();
    return user == null
        ? null
        : gameHttp.joinGame(
            JoinGameRequest(
              userId: user.id,
              gameId: gameInfo.gameId,
              playAsWhite: playAsWhite,
            ),
          );
  }
}
