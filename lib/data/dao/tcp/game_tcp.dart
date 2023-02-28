import "dart:convert";

import "package:batonchess/data/dao/tcp/tcp_client.dart";
import "package:batonchess/data/model/batonchess_tcp_action.dart";
import "package:batonchess/data/model/chess/update_fen_request.dart";
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/model/game/join_game_request.dart";

enum TcpGameAction { joinGame, updateFen, refusedAction }

class GameTcp {
  final TcpClient tcpClient = TcpClient();

  final actions = {
    TcpGameAction.joinGame: "JOIN_GAME",
    TcpGameAction.updateFen: "UPDATE_FEN",
    TcpGameAction.refusedAction: "REFUSED",
  };

  Future<void> connect() async => tcpClient.connect();

  Stream<GameState?> joinGame(JoinGameRequest joinReq) {
    if (tcpClient.isNotConnected()) return const Stream.empty();

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
        if (res == actions[TcpGameAction.refusedAction]) {
          return null;
        }
        return GameState.fromJson(jsonDecode(res) as Map<String, dynamic>);
      },
    );
  }

  Future<void> updateFen(UpdateFenRequest makeMoveReq) async {
    if (tcpClient.isNotConnected()) return;

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
    if (tcpClient.isNotConnected()) return;
    tcpClient.disconnect();
  }
}
