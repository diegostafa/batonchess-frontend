import 'package:batonchess/data/model/game_props.dart';
import 'package:batonchess/data/model/player.dart';
import 'package:batonchess/data/model/user.dart';

class GameState {
  final String fen;
  final List<Player> players;
  final List<String> turnQueue;

  GameState({
    required this.fen,
    required this.players,
    required this.turnQueue,
  });

  factory GameState.fromJson(Map<String, dynamic> json) => GameState(
        fen: json["fen"] as String,
        players: json["players"] as List<Player>,
        turnQueue: json["turnQueue"] as List<String>,
      );
}
