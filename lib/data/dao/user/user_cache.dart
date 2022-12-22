
class UserCache {
  final String? username = null;
  factory UserCache() {
    return _singleton;
  }

  UserCache._internal();

  static final UserCache _singleton = UserCache._internal();
}
