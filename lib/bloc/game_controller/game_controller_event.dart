part of "game_controller_bloc.dart";

@immutable
abstract class GameControllerEvent {}

class MakeMoveEvent extends GameControllerEvent {
  final ShortMove move;

  MakeMoveEvent({required this.move});
}
