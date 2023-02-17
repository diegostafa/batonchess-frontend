import 'dart:convert';

import 'package:batonchess/data/model/game_props.dart';
import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';

class GameHttp {
  factory GameHttp() => _singleton;
  GameHttp._internal();
  static final GameHttp _singleton = GameHttp._internal();

  Future<int?> createGame(String creatorId, GameProps gp) async {
    final url = Uri.parse('http://localhost:2023/createGame');

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'creatorId': creatorId,
        'maxPlayersPerSide': gp.maxPlayers,
        'playAsWhite': gp.playAsWhite
      }),
    );
    return null;
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

  Future<List<int>?> getActiveGames() async {
    final url = Uri.parse('http://localhost:2023/getActiveGames');
    final res = await http.get(url);
    return res.statusCode == StatusCode.OK ? [] : [];
  }

  // TODO : createNewGame, joinGame, leaveGame, sendMove
}
