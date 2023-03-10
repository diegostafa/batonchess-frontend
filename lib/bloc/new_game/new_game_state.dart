part of "new_game_bloc.dart";

@immutable
abstract class NewGameState {}

class SettingGamePropsState extends NewGameState {
  final int maxPlayers;
  final bool playAsWhite;

  SettingGamePropsState({
    this.maxPlayers = 1,
    this.playAsWhite = true,
  });

  SettingGamePropsState copyWith({
    int? maxPlayers,
    bool? playAsWhite,
  }) =>
      SettingGamePropsState(
        playAsWhite: playAsWhite ?? this.playAsWhite,
        maxPlayers: maxPlayers ?? this.maxPlayers,
      );
}

class CreatingGameState extends NewGameState {}

class SuccessCreatingGameState extends NewGameState {
  final GameInfo gameInfo;
  final JoinGameRequest joinReq;

  SuccessCreatingGameState({
    required this.gameInfo,
    required this.joinReq,
  });
}

class FailureCreatingGameState extends NewGameState {}
