import "dart:convert";

import 'package:batonchess/data/dao/http/http_client.dart';
import "package:batonchess/data/model/game/create_game_request.dart";
import "package:batonchess/data/model/game/game_info.dart";
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/model/game/join_game_request.dart";
import "package:http/http.dart" as http;
import "package:http_status_code/http_status_code.dart";

enum Endpoint { createGame, joinGame, leaveGame, makeMove, getActiveGames }

class GameHttp {
  final httpClient = HttpClient();
  final Map<Endpoint, String> endpoints = {
    Endpoint.createGame: "createGame",
    Endpoint.joinGame: "joinGame",
    Endpoint.leaveGame: "leaveGame",
    Endpoint.makeMove: "makeMove",
    Endpoint.getActiveGames: "getActiveGames",
  };

  Future<GameInfo?> createGame(CreateGameRequest createGameReq) async {
    final res = await httpClient.post(
      endpoints[Endpoint.createGame]!,
      jsonEncode(createGameReq),
    );

    return res.statusCode == StatusCode.CREATED
        ? GameInfo.fromJson(jsonDecode(res.body) as Map<String, dynamic>)
        : null;
  }

  Future<GameState?> joinGame(JoinGameRequest joinReq) async {
    final res = await httpClient.post(
      endpoints[Endpoint.joinGame]!,
      jsonEncode(joinReq),
    );
    return res.statusCode == StatusCode.ACCEPTED
        ? GameState.fromJson(jsonDecode(res.body) as Map<String, dynamic>)
        : null;
  }

  Future<List<GameInfo>?> getActiveGames() async {
    final res = await httpClient.get(endpoints[Endpoint.getActiveGames]!);
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
