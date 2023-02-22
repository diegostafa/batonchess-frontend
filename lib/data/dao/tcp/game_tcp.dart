import "dart:convert";
import "dart:io";

import "package:batonchess/data/dao/tcp/tcp_client.dart";
import "package:batonchess/data/model/chess/make_move_request.dart";
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/model/game/join_game_request.dart";
import "package:batonchess/data/model/game/leave_game_request.dart";
import "package:batonchess/data/model/user/user.dart";

class GameTcp {
  final TcpClient tcpClient = TcpClient();

  void leaveGame() async {}

  Future<GameState?> joinGame(User u, JoinGameRequest joinReq) async {
    final connected = await tcpClient.connect();
    if (!connected) {
      return null;
    }

    final res = await tcpClient.send(jsonEncode(joinReq));
    return GameState.fromJson(jsonDecode(res) as Map<String, dynamic>);
  }

  Future<GameState?> makeMove(MakeMoveRequest makeMoveReq) async {
    return null;
  }
}
