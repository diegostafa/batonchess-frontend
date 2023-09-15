import "package:http/http.dart" as http;

class HttpClient {
  static const protocol = "http";
  static const host = "ec2-15-160-120-229.eu-south-1.compute.amazonaws.com";
  static const port = 2023;

  Future<http.Response?> get(String endpoint) async {
    try {
      final res = await http.get(Uri.parse("$protocol://$host:$port/$endpoint"));
      return res;
    } catch (_) {
      return null;
    }
  }

  Future<http.Response?> post(String endpoint, String body) async {
    try {
      final res = await http.post(
        Uri.parse("$protocol://$host:$port/$endpoint"),
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
