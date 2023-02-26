import "package:http/http.dart" as http;

class HttpClient {
  static const host = "localhost";
  static const port = 2023;

  Future<http.Response?> get(String endpoint) async {
    try {
      return http.get(Uri.parse("http://$host:$port/$endpoint"));
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> post(String endpoint, String body) async {
    try {
      return http.post(
        Uri.parse("http://$host:$port/$endpoint"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: body,
      );
    } catch (e) {
      return null;
    }
  }
}
