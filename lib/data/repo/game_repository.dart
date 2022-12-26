import 'package:batonchess/bloc/model/game_props.dart';
import 'package:batonchess/bloc/model/game_state.dart';
import 'package:batonchess/bloc/model/move.dart';

class GameRepository {
  Future<GameState> createNewGame(GameProps props) async {
    print("creating a new game");
    print("SLEEPING");
    await Future.delayed(const Duration(seconds: 5));
    print("WOKE UP");
    return GameState(props, 1, [], []);
  }

  Future<void> makeMove(Move move) async {
    print("sending a move");
  }
}
