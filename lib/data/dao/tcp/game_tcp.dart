import "package:batonchess/data/dao/tcp/tcp_client.dart";
import "package:batonchess/data/model/chess/make_move_request.dart";

class GameTcp {
  final tcpClient = TcpClient();

  bool? makeMove(MakeMoveRequest makeMoveReq) {
    return null;
  }

  bool? getGameState(int gameId) {
    return null;
  }
}
