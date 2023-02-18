import 'package:batonchess/data/model/game_props.dart';
import 'package:batonchess/data/model/user.dart';

class GameState {
  final int gameId;
  final String fen;
  final String status;
  final GameProps props;
  final List<User> whiteTeam;
  final List<User> blackTeam;

  GameState({
    required this.gameId,
    required this.fen,
    required this.status,
    required this.props,
    required this.whiteTeam,
    required this.blackTeam,
  });

  factory GameState.fromJson(Map<String, dynamic> json) => GameState(
        gameId: json["id"] as int,
        fen: json["fen"] as String,
        status: json["status"] as String,
        props: json["props"] as GameProps,
        whiteTeam: json["whiteTeam"] as List<User>,
        blackTeam: json["blackTeam"] as List<User>,
      );
}
