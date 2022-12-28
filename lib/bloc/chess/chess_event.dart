part of 'chess_bloc.dart';

@immutable
abstract class ChessEvent {}

class MakeMoveEvent extends ChessEvent {
  final ShortMove move;
  MakeMoveEvent(this.move);
}
