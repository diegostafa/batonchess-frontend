import 'package:batonchess/data/model/game_state.dart';
import 'package:batonchess/data/repo/game_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'join_game_event.dart';
part 'join_game_state.dart';

class JoinGameBloc extends Bloc<JoinGameEvent, JoinGameState> {
  final gameRepo = GameRepository();

  JoinGameBloc() : super(JoinGameInitial()) {
    on<FetchGamesEvent>(fetchGamesHandler);
  }

  Future<void> fetchGamesHandler(
    FetchGamesEvent e,
    Emitter<JoinGameState> emit,
  ) async {
    emit(FetchingActiveGamesState());
    final games = await gameRepo.getActiveGames();
    games == null
        ? emit(FailedToLoadGamesState())
        : emit(GamesLoadedState(games));
  }
}
