import "package:http/http.dart" as http;

class HttpClient {
  static const host = "192.168.1.100";
  static const port = 2023;

  Future<http.Response?> get(String endpoint) async {
    try {
      final res = await http.get(Uri.parse("http://$host:$port/$endpoint"));
      return res;
    } catch (_) {
      return null;
    }
  }

  Future<http.Response?> post(String endpoint, String body) async {
    try {
      final res = await http.post(
        Uri.parse("http://$host:$port/$endpoint"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: body,
      );
      return res;
    } catch (_) {
      return null;
    }
  }
}
