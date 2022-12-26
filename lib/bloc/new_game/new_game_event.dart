part of 'new_game_bloc.dart';

@immutable
abstract class NewGameEvent {}

class ChangeSideRadioEvent extends NewGameEvent {
  final int index;
  ChangeSideRadioEvent(this.index);
}

class ChangeMaxPlayersEvent extends NewGameEvent {
  final int players;
  ChangeMaxPlayersEvent(this.players);
}

class ChangeMinutesPerSideEvent extends NewGameEvent {
  final int minutes;
  ChangeMinutesPerSideEvent(this.minutes);
}

class ChangeSecondsPerMoveEvent extends NewGameEvent {
  final int seconds;
  ChangeSecondsPerMoveEvent(this.seconds);
}

class SubmitCreateGameEvent extends NewGameEvent {}
