import 'package:batonchess/bloc/model/user.dart';
import 'package:batonchess/data/dao/user/user_cache.dart';
import 'package:batonchess/data/dao/user/user_http.dart';
import 'package:batonchess/data/dao/user/user_local.dart';

class UserRepository {
  final userCache = UserCache();
  final userLocal = UserLocal();
  final userHttp = UserHttp();

  Future<bool> updateUsername(String newUsername) async {
    print("update username");
    final id = userCache.user!.id;
    final success = await userHttp.updateUserNameById(id, newUsername);
    if (success) {
      userCache.user!.name = newUsername;
      userLocal.setUserName(newUsername);
    }
    return success;
  }

  Future<User?> tryGetUser() async {
    print("TRY USER CACHE");

    if (userCache.user != null) {
      return userCache.user;
    }

    print("TRY USER LOCAL");
    final id = await userLocal.getUserId();
    final name = await userLocal.getUserName();
    if (id != null && name != null) {
      UserCache().user = User(id: id, name: name);
      return UserCache().user!;
    }

    print("TRY USER REMOTE");
    final user = await userHttp.getNewUser();
    if (user != null) {
      UserCache().user = user;
      return UserCache().user!;
    }

    return null;
  }
}
