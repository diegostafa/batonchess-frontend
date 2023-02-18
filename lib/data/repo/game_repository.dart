import 'package:batonchess/data/dao/game/game_http.dart';
import 'package:batonchess/data/model/game_info.dart';
import 'package:batonchess/data/model/game_props.dart';
import 'package:batonchess/data/model/game_state.dart';
import 'package:batonchess/data/model/move.dart';
import 'package:batonchess/data/repo/user_repository.dart';

class GameRepository {
  final gameHttp = GameHttp();
  final userRepo = UserRepository();

  Future<GameInfo?> createGame(NewGameProps props) async {
    final user = await userRepo.tryGetUser();
    if (user != null) {
      return gameHttp.createGame(
        user.id,
        props,
      );
    }
    return null;
  }

  Future<List<GameInfo>?> getActiveGames() async {
    return gameHttp.getActiveGames();
  }

  Future<void> makeMove(Move move) async {
    print("sending a move");
  }

  Future<GameState?> joinGame(GameInfo gameInfo,
      {required bool playAsWhite,}) async {
    final user = await userRepo.tryGetUser();
    if (user != null) {
      return gameHttp.joinGame(gameInfo.gameId, user.id, playAsWhite);
    }
    return null;
  }
}
