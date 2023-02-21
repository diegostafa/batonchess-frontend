import "package:batonchess/data/dao/http/user_http.dart";
import 'package:batonchess/data/dao/memory/user_memory.dart';
import "package:batonchess/data/model/user/update_username_request.dart";
import "package:batonchess/data/model/user/user.dart";
import "package:batonchess/data/model/user/user_id.dart";

class UserRepository {
  final userMem = UserMemory();
  final userHttp = UserHttp();

  Future<User?> thisOrValidUser(User? u) async {
    if (u != null && await userHttp.isValidUser(UserId(id: u.id))) {
      return u;
    } else {
      final u = await userHttp.getNewUser();
      return u;
    }
  }

  Future<User?> initUser() async {
    final user = await getUser();
    final validUser = await thisOrValidUser(user);
    if (user != null) {
      await userMem.setUser(validUser!);
      return user;
    }
    return null;
  }

  Future<User?> getUser() async {
    final user = await userMem.getUser();
    if (user != null) {
      return user;
    }

    final newUser = await userHttp.getNewUser();
    if (user != null) {
      await userMem.setUser(newUser!);
      return user;
    }

    return null;
  }

  Future<bool> updateUsername(String newUsername) async {
    final user = await getUser();
    if (user == null) {
      return false;
    }

    final success = await userHttp.updateUserName(
      UpdateUsernameRequest(id: user.id, newName: newUsername),
    );

    if (!success) {
      return false;
    }

    user.name = newUsername;
    await userMem.setUser(user);
    return true;
  }
}
