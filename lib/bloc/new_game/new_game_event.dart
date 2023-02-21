part of "new_game_bloc.dart";

@immutable
abstract class NewGameEvent {}

class ChangeSideEvent extends NewGameEvent {
  final int index;
  ChangeSideEvent(this.index);
}

class ChangeMaxPlayersEvent extends NewGameEvent {
  final int sliderVal;
  ChangeMaxPlayersEvent(this.sliderVal);
}

class SubmitCreateGameEvent extends NewGameEvent {}
