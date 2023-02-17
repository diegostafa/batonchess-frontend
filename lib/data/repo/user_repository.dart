import 'package:batonchess/bloc/model/user.dart';
import 'package:batonchess/data/dao/user/user_cache.dart';
import 'package:batonchess/data/dao/user/user_http.dart';
import 'package:batonchess/data/dao/user/user_local.dart';

/**
 * updateUsername
 * tryGetUser
 */

class UserRepository {
  final userCache = UserCache();
  final userLocal = UserLocal();
  final userHttp = UserHttp();

  Future<bool> updateUsername(String newUsername) async {
    print("debug");
    final id = userCache.user!.id;
    final ok = await userHttp.updateUserNameById(id, newUsername);
    if (ok) {
      userCache.user!.name = newUsername;
      userLocal.setUserName(newUsername);
    }
    return ok;
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
      userCache.user = User(id: id, name: name);
      return userCache.user!;
    }

    print("TRY USER REMOTE");
    final user = await userHttp.getNewUser();
    if (user != null) {
      userCache.user = user;
      userLocal.setUser(user);
      return userCache.user!;
    }

    return null;
  }
}
