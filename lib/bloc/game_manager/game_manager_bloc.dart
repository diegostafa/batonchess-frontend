import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/repo/game_repository.dart";
import "package:bloc/bloc.dart";
import "package:meta/meta.dart";

part "game_manager_event.dart";
part "game_manager_state.dart";

class GameManagerBloc extends Bloc<GameManagerEvent, GameManagerState> {
  GameManagerBloc({required GameState gameState})
      : super(IdleGameManagerState(gameState: gameState)) {
    return;
  }
}
