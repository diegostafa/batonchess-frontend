import "dart:async";

import "package:batonchess/data/model/chess/update_fen_request.dart";
import "package:batonchess/data/model/game/game_id.dart";
import "package:batonchess/data/model/game/game_state.dart";
import "package:batonchess/data/model/game/join_game_request.dart";
import "package:batonchess/data/repo/game_repository.dart";
import "package:batonchess/data/repo/user_repository.dart";
import "package:batonchess/utils/chess_utils.dart";
import "package:bloc/bloc.dart";
import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart";
import "package:meta/meta.dart";

part "game_controller_event.dart";
part "game_controller_state.dart";

class GameControllerBloc
    extends Bloc<GameControllerEvent, GameControllerState> {
  final userRepo = UserRepository();
  final gameRepo = GameRepository();
  final chessEngine = ChessEngineAdapter();
  final gameStateController = StreamController<GameState>.broadcast();
  Stream<GameState> get gameState => gameStateController.stream;

  @override
  Future<void> close() async {
    await gameRepo.leaveGame();
    super.close();
  }

  GameControllerBloc() : super(InitialGameControllerState()) {
    on<JoinGameEvent>(joinGameHandler);
    on<SubmitMoveEvent>(submitMoveHandler);
    on<NewGameStateEvent>(newGameStateHandler);
  }

  Future<void> joinGameHandler(
    JoinGameEvent e,
    Emitter<GameControllerState> emit,
  ) async {
    emit(JoiningGameControllerState());
    await gameRepo.setupGameTcp();
    final responses = gameRepo.joinGame(e.joinReq);

    responses.listen((gameState) {
      if (gameState != null) {
        add(
          NewGameStateEvent(
            gameId: GameId(id: e.joinReq.gameId),
            gameState: gameState,
          ),
        );
      }
    });
  }

  Future<void> submitMoveHandler(
    SubmitMoveEvent e,
    Emitter<GameControllerState> emit,
  ) async {
    if (state is ReadyGameControllerState) {
      final s = state as ReadyGameControllerState;
      final u = await userRepo.getUser();

      if (u == null) return;
      if (s.gameState.userToPlay.id != u.id) return;

      final newFen = chessEngine.execMove(s.gameState.fen, e.move);
      if (newFen == null) {
        return;
      }

      gameRepo.sendMove(
        UpdateFenRequest(gameId: s.gameId.id, userId: u.id, newFen: newFen),
      );
    }
  }

  Future<void> newGameStateHandler(
    NewGameStateEvent e,
    Emitter<GameControllerState> emit,
  ) async {
    emit(ReadyGameControllerState(gameId: e.gameId, gameState: e.gameState));
  }
}
