part of 'chessboard_bloc.dart';

@immutable
abstract class ChessboardState {}

class NormalChessboardState extends ChessboardState {
  final String fen;

  NormalChessboardState({this.fen = initialFen});

  NormalChessboardState copyWith({String? fen, ChessGameState? gameState}) =>
      NormalChessboardState(
        fen: fen ?? this.fen,
      );
}

class FinalChessboardState extends ChessboardState {
  final String finalFen;
  final ChessGameState finalGameState;

  FinalChessboardState({
    required this.finalFen,
    required this.finalGameState,
  });
}
