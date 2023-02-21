import "package:http/http.dart" as http;

class HttpClient {
  static const server = "http://localhost:2023";
  static const headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };

  Future<http.Response> get(String endpoint) async {
    return http.get(Uri.parse("$server/$endpoint"));
  }

  Future<http.Response> post(String endpoint, String body) async {
    return http.post(
      Uri.parse("$server/$endpoint"),
      headers: headers,
      body: body,
    );
  }
}
