import "dart:async";
import "dart:convert";
import "dart:io";

import "package:flutter/material.dart";

class TcpClient {
  static final TcpClient _singleton = TcpClient._internal();
  factory TcpClient() => _singleton;
  TcpClient._internal();

  static const host = "localhost";
  static const port = 2024;
  late Socket? socket;

  bool isConnected() {
    return socket != null;
  }

  Future<void> connect() async {
    try {
      socket = await Socket.connect(host, port);
    } catch (_) {
      socket = null;
    }
  }

  Future<String?> send(String message) async {
    if (socket == null) return null;

    socket!.write("$message\n");

    final completer = Completer<String>();
    socket!.listen((data) {
      completer.complete(utf8.decode(data).trim());
    });

    final response = await completer.future;
    socket?.destroy();
    return response;
  }
}
