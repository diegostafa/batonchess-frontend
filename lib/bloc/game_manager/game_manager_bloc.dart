import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_manager_event.dart';
part 'game_manager_state.dart';

class GameManagerBloc extends Bloc<GameManagerEvent, GameManagerState> {
  GameManagerBloc() : super(GameInitial()) {
    on<GameManagerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
