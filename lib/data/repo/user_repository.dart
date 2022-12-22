import 'package:batonchess/bloc/model/user.dart';

User u = User(id: "ciao", name: "anon");

class UserRepository {
  // dao

  Future<void> updateUsername(String newUsername) async {
    print("update username");
    /**
     * (assume the user exists locally and remotely)
     * async dao.updateUser(id, newName)
     * async local.updateUser(id, newName)
     * update inMemory
     * update locally
     * update remote
     */
    u.name = newUsername;
  }

  Future<User> getOrCreateUser() async {
    print("try get user");
    /**
     * check local storage
     * if there is an id
     * get id
     * get username
     * return user(id,username)
     * else
     * let id = uuid
     * let name = anon
     * let user=(id, name)
     * dao.putUser(user)
     * return user
     */

    return u;
  }
}
