import 'package:batonchess/data/dao/user/user_cache.dart';
import 'package:batonchess/data/dao/user/user_http.dart';
import 'package:batonchess/data/dao/user/user_local.dart';
import 'package:batonchess/data/model/user.dart';

class UserRepository {
  final userCache = UserCache();
  final userLocal = UserLocal();
  final userHttp = UserHttp();

  Future<void> saveUser(User? user) async {
    if (user != null) {
      userCache.user = user;
      userLocal.setUser(user);
    }
  }

  Future<User?> thisOrValidUser(User u) async {
    if (await userHttp.isValidUser(u.id)) {
      return u;
    } else {
      final u = await userHttp.getNewUser();
      saveUser(u);
      return u;
    }
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

    final u = await userHttp.getNewUser();
    saveUser(u);
    return u;
  }

  Future<User?> createUser() async {
    print("TRY USER LOCAL");
    final id = await userLocal.getUserId();
    final name = await userLocal.getUserName();
    if (id != null && name != null) {
      userCache.user = User(id: id, name: name);
      return thisOrValidUser(userCache.user!);
    }
    print("TRY USER REMOTE");
    final u = await userHttp.getNewUser();
    saveUser(u);
    return u;
  }

  Future<bool> updateUsername(String newUsername) async {
    final ok =
        await userHttp.updateUserNameById(userCache.user!.id, newUsername);
    if (ok) {
      userCache.user!.name = newUsername;
      userLocal.setUserName(newUsername);
    }
    return ok;
  }
}
