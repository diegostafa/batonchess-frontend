import "dart:async";
import "dart:io";

class TcpClient {
  static final TcpClient _singleton = TcpClient._internal();
  factory TcpClient() => _singleton;
  TcpClient._internal();

  static const host = "ec2-15-160-120-229.eu-south-1.compute.amazonaws.com";
  static const port = 2024;
  Socket? socket;
  StreamController<String?>? controller;

  bool isConnected() => socket != null;
  bool isNotConnected() => socket == null;

  Future<void> connect() async {
    if (isNotConnected()) {
      try {
        socket = await Socket.connect(host, port);
      } catch (_) {
        socket = null;
      }
    }
  }

  Future<void> send(String msg) async {
    if (isNotConnected()) return;
    socket!.write("$msg\n");
  }

  Stream<String?> listener() {
    if (isNotConnected()) return const Stream.empty();

    controller = StreamController<String?>();
    socket!.listen((data) {
      final response = String.fromCharCodes(data);
      controller?.add(response);
    });

    return controller!.stream;
  }

  void disconnect() {
    controller?.close();
    controller = null;
    socket?.close();
    socket = null;
  }
}
