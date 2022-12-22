
class UserCache {
  final String? username = null;

  UserCache._internal();
  factory UserCache() {
    return _singleton;
  }

  static final UserCache _singleton = UserCache._internal();
}
