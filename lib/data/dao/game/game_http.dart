import 'dart:convert';

import 'package:batonchess/bloc/model/game_state.dart';
import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';

class GameHttp {
  factory GameHttp() => _singleton;
  GameHttp._internal();
  static final GameHttp _singleton = GameHttp._internal();

  // TODO : createNewGame, joinGame, leaveGame, sendMove
}
