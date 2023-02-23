import "package:batonchess/data/model/user/user_player.dart";

class GameState {
  final String fen;
  final List<UserPlayer> players;
  final String userIdTurn;
  final bool waitingForPlayers;

  GameState({
    required this.fen,
    required this.players,
    required this.userIdTurn,
    required this.waitingForPlayers,
  });

  factory GameState.fromJson(Map<String, dynamic> json) => GameState(
        fen: json["fen"] as String,
        players: () {
          if (json["players"] == null) return <UserPlayer>[];

          final List<dynamic> userPlayersJson =
              json["players"] as List<dynamic>;
          final userPlayers = userPlayersJson
              .map((e) => UserPlayer.fromJson(e as Map<String, dynamic>))
              .toList();
          return userPlayers;
        }(),
        userIdTurn: json["userIdTurn"] as String,
        waitingForPlayers: json["waitingForPlayers"] as bool,
      );
}
