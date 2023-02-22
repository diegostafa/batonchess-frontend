import "dart:convert";

import "package:batonchess/data/dao/http/http_client.dart";
import "package:batonchess/data/model/game/create_game_request.dart";
import "package:batonchess/data/model/game/game_info.dart";
import "package:http_status_code/http_status_code.dart";

enum Endpoint { createGame, getActiveGames }

class GameHttp {
  final httpClient = HttpClient();
  final Map<Endpoint, String> endpoints = {
    Endpoint.createGame: "createGame",
    Endpoint.getActiveGames: "getActiveGames",
  };

  Future<GameInfo?> createGame(CreateGameRequest createGameReq) async {
    final res = await httpClient.post(
      endpoints[Endpoint.createGame]!,
      jsonEncode(createGameReq),
    );

    if (res.statusCode != StatusCode.CREATED) return null;
    return GameInfo.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }

  Future<List<GameInfo>?> getActiveGames() async {
    final res = await httpClient.get(endpoints[Endpoint.getActiveGames]!);
    if (res.statusCode != StatusCode.OK) return null;

    final gameInfosJson = jsonDecode(res.body) as List<dynamic>;
    final gameInfos = gameInfosJson
        .map((e) => GameInfo.fromJson(e as Map<String, dynamic>))
        .toList();
    return gameInfos;
  }
}
