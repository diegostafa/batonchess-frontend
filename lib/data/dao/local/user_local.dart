import 'package:batonchess/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocal {
  factory UserLocal() => _singleton;
  UserLocal._internal();
  static final UserLocal _singleton = UserLocal._internal();

  Future<SharedPreferences> prefs() async => SharedPreferences.getInstance();

  Future<String?> getUserId() async => (await prefs()).getString("user_id");

  Future<String?> getUserName() async => (await prefs()).getString("user_name");

  Future<void> setUserId(String id) async =>
      (await prefs()).setString("user_id", id);

  Future<void> setUserName(String name) async =>
      (await prefs()).setString("user_name", name);

  Future<void> setUser(User user) async {
    (await prefs()).setString("user_id", user.id);
    (await prefs()).setString("user_name", user.name);
  }
}
