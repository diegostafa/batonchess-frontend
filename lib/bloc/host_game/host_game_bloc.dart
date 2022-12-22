import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'host_game_event.dart';
part 'host_game_state.dart';

class NewGameBloc extends Bloc<NewGameEvent, NewGameState> {
  NewGameBloc() : super(NewGameInitial()) {
    on<NewGameEvent>((event, emit) {});
  }
}
