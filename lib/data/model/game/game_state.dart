import "package:batonchess/data/model/user/user_player.dart";

class GameState {
  final String fen;
  final List<UserPlayer> players;
  final String userIdTurn;

  GameState({
    required this.fen,
    required this.players,
    required this.userIdTurn,
  });

  factory GameState.fromJson(Map<String, dynamic> json) => GameState(
        fen: json["fen"] as String,
        players: () {
          final List<dynamic> userPlayersJson =
              json["players"] as List<dynamic>;
          final userPlayers = userPlayersJson
              .map((e) => UserPlayer.fromJson(e as Map<String, dynamic>))
              .toList();
          return userPlayers;
        }(),
        userIdTurn: json["userIdTurn"] as String,
      );
}
