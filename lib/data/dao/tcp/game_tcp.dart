import "dart:convert";

import "package:batonchess/data/dao/tcp/tcp_client.dart";
import "package:batonchess/data/model/batonchess_tcp_action.dart";
import "package:batonchess/data/model/chess/make_move_request.dart";
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/model/game/join_game_request.dart";

enum TcpGameAction { joinGame, leaveGame, makeMove }

class GameTcp {
  final TcpClient tcpClient = TcpClient();

  final actions = {
    TcpGameAction.joinGame: "join_game",
    TcpGameAction.leaveGame: "leave_game",
    TcpGameAction.makeMove: "make_move",
  };

  Future<void> leaveGame() async {}

  Future<GameState?> joinGame(JoinGameRequest joinReq) async {
    final connected = await tcpClient.connect();
    if (!connected) {
      return null;
    }

    final res = await tcpClient.send(jsonEncode(BatonchessTcpAction(
        actionType: actions[TcpGameAction.joinGame]!, actionBody: joinReq,),),);

    return GameState.fromJson(jsonDecode(res) as Map<String, dynamic>);
  }

  Future<GameState?> makeMove(MakeMoveRequest makeMoveReq) async {
    return null;
  }
}
