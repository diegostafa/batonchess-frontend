import "dart:async";
import "dart:convert";
import "dart:io";

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
    socket.write("$message\n");

    final completer = Completer<String>();
    socket.listen((data) {
      completer.complete(utf8.decode(data).trim());
    });

    print("WAITING RESPONSE");
    final response = await completer.future;
    return response;
  }
}
