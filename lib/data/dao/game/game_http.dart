import 'dart:convert';

import 'package:batonchess/data/model/game_info.dart';
import 'package:batonchess/data/model/game_props.dart';
import 'package:batonchess/data/model/game_state.dart';
import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';

class GameHttp {
  factory GameHttp() => _singleton;
  GameHttp._internal();
  static final GameHttp _singleton = GameHttp._internal();

  Future<GameInfo?> createGame(String creatorId, NewGameProps gp) async {
    final url = Uri.parse('http://localhost:2023/createGame');

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'creatorId': creatorId,
        'maxPlayersPerSide': gp.maxPlayers,
      }),
    );

    return null;
  }

  Future<GameState?> joinGame(
      int gameId, String userId, bool playAsWhite,) async {
    final url = Uri.parse('http://localhost:2023/createGame');

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'gameId': gameId,
        'userId': userId,
      }),
    );

    return null;
  }

  Future<bool> leaveGame() async {
    return false;
  }

  Future<bool> sendMove() async {
    return false;
  }

  Future<List<GameInfo>?> getActiveGames() async {
    final url = Uri.parse('http://localhost:2023/getActiveGames');
    final res = await http.get(url);
    print("HELLO");
    print(res.body);
    if (res.statusCode == StatusCode.OK) {
      //Game.fromJson(jsonDecode(res.body) as Map<String, dynamic>)
      // List<dynamic> jsonList = json.decode(res.body);
      // List<GameState> gs =
      //     jsonList.map((json) => GamesState.fromJson(json)).toList();
      return [];
    } else {
      return null;
    }
  }

  // TODO : createNewGame, joinGame, leaveGame, sendMove
}
