import "dart:convert";

import "package:batonchess/data/dao/tcp/tcp_client.dart";
import "package:batonchess/data/model/batonchess_tcp_action.dart";
import "package:batonchess/data/model/chess/update_fen_request.dart";
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/model/game/join_game_request.dart";

enum TcpGameAction { joinGame, updateFen }

const refusedAction = "REFUSED";

class GameTcp {
  final TcpClient tcpClient = TcpClient();

  final actions = {
    TcpGameAction.joinGame: "JOIN_GAME",
    TcpGameAction.updateFen: "UPDATE_FEN",
  };

  Future<void> connect() async {
    await tcpClient.connect();
  }

  Stream<GameState?> joinGame(JoinGameRequest joinReq) {
    if (!tcpClient.isConnected()) return const Stream.empty();

    tcpClient.send(
      jsonEncode(
        BatonchessTcpAction(
          actionType: actions[TcpGameAction.joinGame]!,
          actionBody: joinReq,
        ),
      ),
    );

    final stream = tcpClient.listener();
    return stream.map(
      (res) {
        if (res == null) return null;
        if (res == refusedAction) return null;
        return GameState.fromJson(jsonDecode(res) as Map<String, dynamic>);
      },
    );
  }

  Future<void> updateFen(UpdateFenRequest makeMoveReq) async {
    if (!tcpClient.isConnected()) return;

    tcpClient.send(
      jsonEncode(
        BatonchessTcpAction(
          actionType: actions[TcpGameAction.updateFen]!,
          actionBody: makeMoveReq,
        ),
      ),
    );
  }

  Future<void> leaveGame() async {
    if (!tcpClient.isConnected()) return;

    tcpClient.disconnect();
  }
}
