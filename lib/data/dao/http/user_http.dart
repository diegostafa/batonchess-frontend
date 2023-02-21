import "dart:convert";

import "package:batonchess/data/dao/http/http_dao.dart";
import "package:batonchess/data/model/user/update_username_request.dart";
import "package:batonchess/data/model/user/user.dart";
import "package:batonchess/data/model/user/user_id.dart";
import "package:http/http.dart" as http;
import "package:http_status_code/http_status_code.dart";

enum Endpoint { getNewUser, isValidUser, updateUserName }

class UserHttp {
  final Map<Endpoint, String> endpoints = {
    Endpoint.getNewUser: "${HttpDao.server}/createUser",
    Endpoint.isValidUser: "${HttpDao.server}/isValidUser",
    Endpoint.updateUserName: "${HttpDao.server}/updateUserName",
  };

  Future<User?> getNewUser() async {
    final res = await http.get(
      Uri.parse(endpoints[Endpoint.getNewUser]!),
    );

    return res.statusCode == StatusCode.CREATED
        ? User.fromJson(jsonDecode(res.body) as Map<String, dynamic>)
        : null;
  }

  Future<bool> isValidUser(UserId userId) async {
    final res = await http.post(
      Uri.parse(endpoints[Endpoint.isValidUser]!),
      headers: HttpDao.headers,
      body: jsonEncode(userId),
    );

    return res.statusCode == StatusCode.OK;
  }

  Future<bool> updateUserName(UpdateUsernameRequest updateNameReq) async {
    final res = await http.post(
      Uri.parse(endpoints[Endpoint.updateUserName]!),
      headers: HttpDao.headers,
      body: jsonEncode(updateNameReq),
    );

    return res.statusCode == StatusCode.ACCEPTED;
  }
}
