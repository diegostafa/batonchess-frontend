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
    print("WAITING SERVER");
    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'creatorId': creatorId,
        'maxPlayers': gp.maxPlayers,
      }),
    );

    return res.statusCode == StatusCode.CREATED
        ? GameInfo.fromJson(jsonDecode(res.body) as Map<String, dynamic>)
        : null;
  }

  Future<GameState?> joinGame(
    int gameId,
    String userId,
    bool playAsWhite,
  ) async {
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
    if (res.statusCode == StatusCode.OK) {
      final List<dynamic> gameInfosJson = jsonDecode(res.body) as List<dynamic>;
      final gameInfos = gameInfosJson
          .map((e) => GameInfo.fromJson(e as Map<String, dynamic>))
          .toList();
      return gameInfos;
    } else {
      return null;
    }
  }
}
