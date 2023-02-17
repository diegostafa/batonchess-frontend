import 'package:batonchess/data/model/user.dart';

class UserCache {
  static final UserCache _singleton = UserCache._internal(null);
  factory UserCache() => _singleton;
  UserCache._internal(this.user);

  User? user;
}
