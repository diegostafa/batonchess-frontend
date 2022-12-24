import 'package:batonchess/bloc/model/game_props.dart';
import 'package:batonchess/bloc/model/game_state.dart';
import 'package:batonchess/bloc/model/user.dart';

GameState gs = GameState(
    GameProps(
        maxPlayers: 10, side: Side.white, minPerSide: 10, incrementPerMove: 2),
    0,
    [],
    []);

class GameRepository {
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
  }

  Future<GameState> getOrCreateUser() async {
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

    return gs;
  }
}
