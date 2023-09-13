part of "join_game_bloc.dart";

@immutable
abstract class JoinGameEvent {}

class FetchGamesEvent extends JoinGameEvent {}

class ChooseGameEvent extends JoinGameEvent {}

class SubmitJoinGameEvent extends JoinGameEvent {
  final GameInfo targetGame;
  final int? sideIndex;

  SubmitJoinGameEvent(this.targetGame, this.sideIndex);
}
