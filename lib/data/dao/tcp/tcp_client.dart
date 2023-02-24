import "dart:async";
import "dart:io";

class TcpClient {
  static final TcpClient _singleton = TcpClient._internal();
  factory TcpClient() => _singleton;
  TcpClient._internal();

  static const host = "localhost";
  static const port = 2024;
  Socket? socket;

  bool isConnected() => socket != null;

  Future<void> connect() async {
    if (!isConnected()) {
      try {
        socket = await Socket.connect(host, port);
        print("CONNECTED");
      } catch (_) {
        socket = null;
      }
    }
  }

  Future<void> send(String msg) async {
    if (!isConnected()) return;
    print("SENDING");
    socket!.write("$msg\n");
  }

  Stream<String?> listener() {
    if (!isConnected()) return const Stream.empty();
    print("TAKING LISTENER");

    final controller = StreamController<String?>();
    socket!.asBroadcastStream().listen((data) {
      final response = String.fromCharCodes(data);
      controller.add(response);
    });

    return controller.stream;
  }
}
