import "dart:async";
import "dart:io";

import 'dart:convert';
import 'dart:io';
import "dart:typed_data";
import "package:batonchess/data/model/game/join_game_request.dart";
import "package:batonchess/data/model/game/leave_game_request.dart";
import "package:batonchess/data/model/user/user.dart";

class TcpClient {
  static final TcpClient _singleton = TcpClient._internal();
  factory TcpClient() => _singleton;
  TcpClient._internal();

  static const host = "localhost";
  static const port = 2024;
  late Socket socket;

  Future<bool> connect() async {
    try {
      socket = await Socket.connect(host, port);
      return true;
    } catch (_) {
      return false;
    }
  }

  void disconnect() {
    socket.destroy();
  }

  Future<String> send(String message) async {
    print("sending ${message}");
    socket.write(jsonEncode(message));

    final completer = Completer<String>();
    socket.listen((data) {
      completer.complete(utf8.decode(data).trim());
    });

    final response = await completer.future;
    print("Received response: $response");
    return response;
  }
}
