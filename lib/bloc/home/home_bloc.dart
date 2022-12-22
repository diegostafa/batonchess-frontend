import 'package:batonchess/bloc/model/user.dart';
import 'package:batonchess/data/repo/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final userRepo = UserRepository();

  HomeBloc() : super(InitialHomeState()) {
    on<FetchUserEvent>(setupUserHandler);
    on<UpdateUsernameEvent>(updateUsernameHandler);
  }

  Future<void> setupUserHandler(
      FetchUserEvent e, Emitter<HomeState> emit,) async {
    emit(FetchingUserState());
    final user = await userRepo.getOrCreateUser();
    emit(UserLoadedState(user));
  }

  Future<void> updateUsernameHandler(
      UpdateUsernameEvent e, Emitter<HomeState> emit,) async {
    if (e.newUsername != null) {
      emit(FetchingUserState());
      await userRepo.updateUsername(e.newUsername!);
      final user = await userRepo.getOrCreateUser();
      emit(UserLoadedState(user));
    }
  }
}
