import 'package:batonchess/bloc/model/game_props.dart';
import 'package:batonchess/bloc/model/user.dart';

class GameState {
  final GameProps props;
  final int gameId;
  final List<User> whiteTeam;
  final List<User> blackTeam;

  GameState(this.props, this.gameId, this.whiteTeam, this.blackTeam);

  // gameProps
  // gameId
  // white : List<Users>?
  // black : List<Users>?
}
