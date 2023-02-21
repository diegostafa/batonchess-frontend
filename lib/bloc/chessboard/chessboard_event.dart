part of "chessboard_bloc.dart";

@immutable
abstract class ChessboardEvent {}

class MakeMoveEvent extends ChessboardEvent {
  final ShortMove move;
  MakeMoveEvent(this.move);
}
