import "dart:convert";

import "package:batonchess/data/dao/http/http_client.dart";
import "package:batonchess/data/model/user/update_username_request.dart";
import "package:batonchess/data/model/user/user.dart";
import "package:batonchess/data/model/user/user_id.dart";
import "package:http_status_code/http_status_code.dart";

enum Endpoint { createUser, isValidUser, updateUserName }

class UserHttp {
  final httpClient = HttpClient();

  final endpoints = {
    Endpoint.createUser: "createUser",
    Endpoint.isValidUser: "isValidUser",
    Endpoint.updateUserName: "updateUserName",
  };

  Future<User?> getNewUser() async {
    final res = await httpClient.get(endpoints[Endpoint.createUser]!);

    if (res.statusCode != StatusCode.CREATED) return null;

    return User.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
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
