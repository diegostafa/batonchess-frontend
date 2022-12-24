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

class ChangeTimeFormatRadioEvent extends NewGameEvent {
  final int index;
  ChangeTimeFormatRadioEvent(this.index);
}

class SubmitCreateGameEvent extends NewGameEvent {}
