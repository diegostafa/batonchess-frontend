import "package:batonchess/data/model/user/user_player.dart";

class GameState {
  final String fen;
  final List<UserPlayer> whiteQueue;
  final List<UserPlayer> blackQueue;
  final UserPlayer userToPlay;
  final bool waitingForPlayers;
  final String boardState;

  GameState({
    required this.fen,
    required this.whiteQueue,
    required this.blackQueue,
    required this.userToPlay,
    required this.waitingForPlayers,
    required this.boardState,
  });

  factory GameState.fromJson(Map<String, dynamic> json) => GameState(
        fen: json["fen"] as String,
        whiteQueue: UserPlayer.fromJsonList(json["whiteQueue"]),
        blackQueue: UserPlayer.fromJsonList(json["blackQueue"]),
        userToPlay:
            UserPlayer.fromJson(json["userToPlay"] as Map<String, dynamic>),
        waitingForPlayers: json["waitingForPlayers"] as bool,
        boardState: json["boardState"] as String,
      );

  GameState copyWith({
    String? fen,
    List<UserPlayer>? whiteQueue,
    List<UserPlayer>? blackQueue,
    UserPlayer? userToPlay,
    bool? waitingForPlayers,
    String? boardState,
  }) =>
      GameState(
        fen: fen ?? this.fen,
        whiteQueue: whiteQueue ?? this.whiteQueue,
        blackQueue: blackQueue ?? this.blackQueue,
        userToPlay: userToPlay ?? this.userToPlay,
        waitingForPlayers: waitingForPlayers ?? this.waitingForPlayers,
        boardState: boardState ?? this.boardState,
      );
}
