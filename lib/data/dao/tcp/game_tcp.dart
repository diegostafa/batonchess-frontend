import "dart:convert";

import "package:batonchess/data/dao/tcp/tcp_client.dart";
import "package:batonchess/data/model/batonchess_tcp_action.dart";
import 'package:batonchess/data/model/chess/update_fen_request.dart';
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/model/game/join_game_request.dart";

enum TcpGameAction { joinGame, leaveGame, updateFen }

const discardedMoveMessage = "DISCARDED";

class GameTcp {
  final TcpClient tcpClient = TcpClient();

  final actions = {
    TcpGameAction.joinGame: "JOIN_GAME",
    TcpGameAction.leaveGame: "LEAVE_GAME",
    TcpGameAction.updateFen: "UPDATE_FEN",
  };

  Future<void> leaveGame() async {}

  Future<GameState?> joinGame(JoinGameRequest joinReq) async {
    await tcpClient.connect();
    if (!tcpClient.isConnected()) {
      return null;
    }

    final res = await tcpClient.send(
      jsonEncode(
        BatonchessTcpAction(
          actionType: actions[TcpGameAction.joinGame]!,
          actionBody: joinReq,
        ),
      ),
    );
    if (res == null) return null;
    return GameState.fromJson(jsonDecode(res) as Map<String, dynamic>);
  }

  Future<GameState?> updateFen(UpdateFenRequest makeMoveReq) async {
    await tcpClient.connect();
    if (!tcpClient.isConnected()) {
      return null;
    }

    final res = await tcpClient.send(
      jsonEncode(
        BatonchessTcpAction(
          actionType: actions[TcpGameAction.updateFen]!,
          actionBody: makeMoveReq,
        ),
      ),
    );
    if (res == null) return null;
    if (res == discardedMoveMessage) return null;
    return GameState.fromJson(jsonDecode(res) as Map<String, dynamic>);
  }
}
