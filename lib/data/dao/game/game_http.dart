import 'dart:convert';

import 'package:batonchess/bloc/model/game_props.dart';
import 'package:http/http.dart' as http;

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

  // TODO : createNewGame, joinGame, leaveGame, sendMove
}
