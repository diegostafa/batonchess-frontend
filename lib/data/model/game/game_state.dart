import "package:batonchess/data/model/user/user_player.dart";

enum Method {
  noMethod,
  checkmate,
  resignation,
  drawOffer,
  stalemate,
  threefoldRepetition,
  fivefoldRepetition,
  fiftyMoveRule,
  seventyFiveMoveRule,
  insufficientMaterial,
}

class GameState {
  final String fen;
  final List<UserPlayer> whiteQueue;
  final List<UserPlayer> blackQueue;
  final UserPlayer userToPlay;
  final bool waitingForPlayers;
  final String outcome;
  final Method method;

  GameState({
    required this.fen,
    required this.whiteQueue,
    required this.blackQueue,
    required this.userToPlay,
    required this.waitingForPlayers,
    required this.outcome,
    required this.method,
  });

  factory GameState.fromJson(Map<String, dynamic> json) => GameState(
        fen: json["fen"] as String,
        whiteQueue: UserPlayer.fromJsonList(json["whiteQueue"]),
        blackQueue: UserPlayer.fromJsonList(json["blackQueue"]),
        userToPlay:
            UserPlayer.fromJson(json["userToPlay"] as Map<String, dynamic>),
        waitingForPlayers: json["waitingForPlayers"] as bool,
        outcome: json["outcome"] as String,
        method: Method.values[(json["method"] as int)],
      );

  GameState copyWith({
    String? fen,
    List<UserPlayer>? whiteQueue,
    List<UserPlayer>? blackQueue,
    UserPlayer? userToPlay,
    bool? waitingForPlayers,
    String? outcome,
    Method? method,
  }) =>
      GameState(
        fen: fen ?? this.fen,
        whiteQueue: whiteQueue ?? this.whiteQueue,
        blackQueue: blackQueue ?? this.blackQueue,
        userToPlay: userToPlay ?? this.userToPlay,
        waitingForPlayers: waitingForPlayers ?? this.waitingForPlayers,
        outcome: outcome ?? this.outcome,
        method: method ?? this.method,
      );

  bool ongoing() => outcome == "*";
  bool whiteWon() => outcome == "1-0";
  bool blackWon() => outcome == "0-1";
  bool draw() => outcome == "1/2-1/2";

  String prettyBoardState() {
    if (whiteWon()) {
      return "White won by ${method.name}";
    }
    if (blackWon()) {
      return "Black won by ${method.name}";
    }
    if (draw()) {
      return "Draw by ${method.name}";
    }

    if (waitingForPlayers) {
      return "Waiting for players...";
    }

    if (userToPlay.playingAsWhite) {
      return "White to move: ${userToPlay.name}";
    } else {
      return "Black to move: ${userToPlay.name}";
    }
  }
}
