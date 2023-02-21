import "dart:convert";

import 'package:batonchess/data/dao/http/http_client.dart';
import "package:batonchess/data/model/user/update_username_request.dart";
import "package:batonchess/data/model/user/user.dart";
import "package:batonchess/data/model/user/user_id.dart";
import "package:http/http.dart" as http;
import "package:http_status_code/http_status_code.dart";

enum Endpoint { createUser, isValidUser, updateUserName }

class UserHttp {
  final httpClient = HttpClient();

  final Map<Endpoint, String> endpoints = {
    Endpoint.createUser: "createUser",
    Endpoint.isValidUser: "isValidUser",
    Endpoint.updateUserName: "updateUserName",
  };

  Future<User?> getNewUser() async {
    final res = await httpClient.get(endpoints[Endpoint.isValidUser]!);
    return res.statusCode == StatusCode.CREATED
        ? User.fromJson(jsonDecode(res.body) as Map<String, dynamic>)
        : null;
  }

  Future<bool> isValidUser(UserId userId) async {
    final res = await httpClient.post(
      endpoints[Endpoint.isValidUser]!,
      jsonEncode(userId),
    );

    return res.statusCode == StatusCode.OK;
  }

  Future<bool> updateUserName(UpdateUsernameRequest updateNameReq) async {
    final res = await httpClient.post(
      endpoints[Endpoint.updateUserName]!,
      jsonEncode(updateNameReq),
    );

    return res.statusCode == StatusCode.ACCEPTED;
  }
}
