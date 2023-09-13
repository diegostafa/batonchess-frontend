import "package:batonchess/data/dao/http/user_http.dart";
import "package:batonchess/data/dao/memory/user_memory.dart";
import "package:batonchess/data/model/user/update_username_request.dart";
import "package:batonchess/data/model/user/user.dart";
import "package:batonchess/data/model/user/user_id.dart";

class UserRepository {
  final userMem = UserMemory();
  final userHttp = UserHttp();

  Future<User?> getUser() async {
    final user = await userMem.getUser();
    if (user != null && await userHttp.isValidUser(UserId(id: user.id))) {
      return user;
    }

    final freshUser = await userHttp.getNewUser();
    if (freshUser != null) {
      await userMem.setUser(freshUser);
      return freshUser;
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
