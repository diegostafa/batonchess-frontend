import 'package:batonchess/data/model/game_props.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'join_game_event.dart';
part 'join_game_state.dart';

class JoinGameBloc extends Bloc<JoinGameEvent, JoinGameState> {
  JoinGameBloc() : super(JoinGameInitial()) {
    on<JoinGameEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
