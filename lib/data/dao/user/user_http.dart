import 'dart:convert';

import 'package:batonchess/bloc/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';

class UserHttp {
  factory UserHttp() => _singleton;
  UserHttp._internal();
  static final UserHttp _singleton = UserHttp._internal();

  Future<User?> getNewUser() async {
    final url = Uri.parse('http://localhost:2023/createUser');
    final res = await http.get(url);

    return res.statusCode == StatusCode.CREATED
        ? User.fromJson(jsonDecode(res.body) as Map<String, dynamic>)
        : null;
  }

  Future<bool> updateUserNameById(String userId, String newUsername) async {
    final url = Uri.parse(
      'http://localhost:2023/updateUserName/',
    );

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'userId': userId, 'newUsername': newUsername}),
    );

    return res.statusCode == StatusCode.ACCEPTED;
  }
}
