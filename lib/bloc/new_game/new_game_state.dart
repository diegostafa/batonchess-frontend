part of 'new_game_bloc.dart';

@immutable
abstract class NewGameState {}

class GamePropsState extends NewGameState {
  final int maxPlayers;
  final bool playAsWhite;

  GamePropsState({
    this.maxPlayers = 1,
    this.playAsWhite = true,
  });

  GamePropsState copyWith({
    int? maxPlayers,
    bool? playAsWhite,
  }) =>
      GamePropsState(
        playAsWhite: playAsWhite ?? this.playAsWhite,
        maxPlayers: maxPlayers ?? this.maxPlayers,
      );
}

class IsCreatingGameState extends NewGameState {}

class SuccessCreateGameState extends NewGameState {}

class FailedCreateGameState extends NewGameState {}
