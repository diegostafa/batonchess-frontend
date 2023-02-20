import 'dart:convert';

import 'package:batonchess/data/dao/http/http_dao.dart';
import 'package:batonchess/data/model/game/create_game_request.dart';
import 'package:batonchess/data/model/game/game_info.dart';
import 'package:batonchess/data/model/game/game_state.dart';
import 'package:batonchess/data/model/game/join_game_request.dart';
import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';

enum Endpoint { createGame, joinGame, leaveGame, makeMove, getActiveGames }

class GameHttp {
  final Map<Endpoint, String> endpoints = {
    Endpoint.createGame: "${HttpDao.server}/createGame",
    Endpoint.joinGame: "${HttpDao.server}/joinGame",
    Endpoint.leaveGame: "${HttpDao.server}/leaveGame",
    Endpoint.makeMove: "${HttpDao.server}/makeMove",
    Endpoint.getActiveGames: "${HttpDao.server}/getActiveGames",
  };

  Future<GameInfo?> createGame(CreateGameRequest createGameReq) async {
    final res = await http.post(
      Uri.parse(endpoints[Endpoint.createGame]!),
      headers: HttpDao.headers,
      body: jsonEncode(createGameReq),
    );

    return res.statusCode == StatusCode.CREATED
        ? GameInfo.fromJson(jsonDecode(res.body) as Map<String, dynamic>)
        : null;
  }

  Future<GameState?> joinGame(JoinGameRequest joinReq) async {
    print(joinReq.toJson());
    final res = await http.post(
      Uri.parse(endpoints[Endpoint.joinGame]!),
      headers: HttpDao.headers,
      body: jsonEncode(joinReq),
    );
    return res.statusCode == StatusCode.ACCEPTED
        ? GameState.fromJson(jsonDecode(res.body) as Map<String, dynamic>)
        : null;
  }

  Future<bool> leaveGame() async {
    return false;
  }

  Future<bool> makeMove() async {
    return false;
  }

  Future<List<GameInfo>?> getActiveGames() async {
    final res = await http.get(Uri.parse(endpoints[Endpoint.getActiveGames]!));
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
