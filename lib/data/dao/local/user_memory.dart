import 'package:batonchess/data/model/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserMemory {
  factory UserMemory() => _singleton;
  UserMemory._internal();
  static final UserMemory _singleton = UserMemory._internal();

  User? user;

  Future<void> setUser(User u) async {
    user = u;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_id", u.id);
    await prefs.setString("user_name", u.name);
  }

  Future<User?> getUser() async {
    if (user != null) {
      return user;
    }

    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString("user_id");
    final name = prefs.getString("user_name");

    if (id == null || name == null) {
      return null;
    }

    // ignore: join_return_with_assignment
    user = User(id: id, name: name);
    return user;
  }
}
