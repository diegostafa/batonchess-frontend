part of 'chess_bloc.dart';

@immutable
abstract class ChessState {}

class NormalChessState extends ChessState {
  final String fen;

  NormalChessState({this.fen = initialFen});

  NormalChessState copyWith({String? fen, ChessGameState? gameState}) =>
      NormalChessState(
        fen: fen ?? this.fen,
      );
}

class FinalChessState extends ChessState {
  final String finalFen;
  final ChessGameState finalGameState;

  FinalChessState({
    required this.finalFen,
    required this.finalGameState,
  });
}
