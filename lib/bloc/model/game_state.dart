import 'package:batonchess/bloc/model/game_props.dart';
import 'package:batonchess/bloc/model/user.dart';

class GameState {
  final int gameId;
  final GameProps props;
  final List<User> whiteTeam;
  final List<User> blackTeam;

  GameState(
      {required this.gameId,
      required this.props,
      required this.whiteTeam,
      required this.blackTeam,});

  // FIXME
  factory GameState.fromJson(Map<String, dynamic> json) => GameState(
      gameId: json["maxPlayers"] as int,
      props: json["Side"] as GameProps,
      whiteTeam: json["whiteTeam"] as List<User>,
      blackTeam: json["blackTeam"] as List<User>,);
}
