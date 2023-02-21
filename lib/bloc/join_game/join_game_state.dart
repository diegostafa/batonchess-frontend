part of "join_game_bloc.dart";

@immutable
abstract class JoinGameState {}

class JoinGameInitial extends JoinGameState {}

class FetchingGamesState extends JoinGameState {}

class SuccessLoadingGamesState extends JoinGameState {
  final List<GameInfo> games;
  SuccessLoadingGamesState(this.games);
}

class FailureLoadingGamesState extends JoinGameState {}

class JoiningGameState extends JoinGameState {}

class SuccessJoiningGameState extends JoinGameState {
  final GameState joinedGame;
  SuccessJoiningGameState(this.joinedGame);
}

class FailureJoiningGameState extends JoinGameState {}
