part of "game_manager_bloc.dart";

@immutable
abstract class GameManagerEvent {}

class MakeMoveEvent extends GameManagerEvent {
  final ShortMove move;

  MakeMoveEvent({required this.move});
}
