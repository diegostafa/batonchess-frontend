part of 'join_game_bloc.dart';

@immutable
abstract class JoinGameState {}

class JoinGameInitial extends JoinGameState {}

class GamesLoadedState extends JoinGameState {
  final List<GameProps> games;
  GamesLoadedState(this.games);
}

class FetchingActiveGamesState extends JoinGameState {}

class FailedToLoadGamesState extends JoinGameState {}

class ErrorState extends JoinGameState {
  final String msg;

  ErrorState(this.msg);
}
