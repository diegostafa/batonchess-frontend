import 'dart:convert';

import 'package:batonchess/data/dao/http/http_dao.dart';
import 'package:batonchess/data/model/game_info.dart';
import 'package:batonchess/data/model/game_props.dart';
import 'package:batonchess/data/model/game_state.dart';
import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';

enum Endpoint { createGame, joinGame, leaveGame, makeMove, getActiveGames }

class GameHttp {
  final Map<Endpoint, String> endpoints = {
    Endpoint.createGame: "${HttpDao.addr}:${HttpDao.port}/createGame",
    Endpoint.joinGame: "${HttpDao.addr}:${HttpDao.port}/joinGame",
    Endpoint.leaveGame: "${HttpDao.addr}:${HttpDao.port}/leaveGame",
    Endpoint.makeMove: "${HttpDao.addr}:${HttpDao.port}/makeMove",
    Endpoint.getActiveGames: "${HttpDao.addr}:${HttpDao.port}/getActiveGames",
  };

  Future<GameInfo?> createGame(String creatorId, NewGameProps gp) async {
    final res = await http.post(
      Uri.parse(endpoints[Endpoint.createGame]!),
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
    String userId, {
    required bool playAsWhite,
  }) async {
    final res = await http.post(
      Uri.parse(endpoints[Endpoint.joinGame]!),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'gameId': gameId,
        'userId': userId,
        'playAsWhite': playAsWhite,
      }),
    );
    return res.statusCode == StatusCode.OK
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
