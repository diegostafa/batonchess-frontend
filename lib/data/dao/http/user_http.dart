import 'dart:convert';

import 'package:batonchess/data/dao/http/http_dao.dart';
import 'package:batonchess/data/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';

enum Endpoint { getNewUser, isValidUser, updateUserName }

class UserHttp {
  final Map<Endpoint, String> endpoints = {
    Endpoint.getNewUser: "${HttpDao.addr}:${HttpDao.port}/getNewUser",
    Endpoint.isValidUser: "${HttpDao.addr}:${HttpDao.port}/isValidUser",
    Endpoint.updateUserName: "${HttpDao.addr}:${HttpDao.port}/updateUserName",
  };

  Future<User?> getNewUser() async {
    final res = await http.get(
      Uri.parse(endpoints[Endpoint.getNewUser]!),
    );

    return res.statusCode == StatusCode.CREATED
        ? User.fromJson(jsonDecode(res.body) as Map<String, dynamic>)
        : null;
  }

  Future<bool> isValidUser(String userId) async {
    final res = await http.post(
      Uri.parse(endpoints[Endpoint.isValidUser]!),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'userId': userId}),
    );

    return res.statusCode == StatusCode.OK;
  }

  Future<bool> updateUserName(String userId, String newUsername) async {
    final res = await http.post(
      Uri.parse(endpoints[Endpoint.updateUserName]!),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'userId': userId, 'newUsername': newUsername}),
    );

    return res.statusCode == StatusCode.ACCEPTED;
  }
}
