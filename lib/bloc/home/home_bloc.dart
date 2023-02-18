import 'package:batonchess/data/model/user.dart';
import 'package:batonchess/data/repo/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final userRepo = UserRepository();

  HomeBloc() : super(InitialHomeState()) {
    on<FetchUserEvent>(fetchUserHandler);
    on<UpdateUsernameEvent>(updateUsernameHandler);
  }

  Future<void> fetchUserHandler(
    FetchUserEvent e,
    Emitter<HomeState> emit,
  ) async {
    emit(FetchingUserState());
    final user = await userRepo.createUser();
    user == null ? emit(FailedToLoadUserState()) : emit(UserLoadedState(user));
  }

  Future<void> updateUsernameHandler(
    UpdateUsernameEvent e,
    Emitter<HomeState> emit,
  ) async {
    if (e.newUsername != null) {
      emit(FetchingUserState());
      await userRepo.updateUsername(e.newUsername!)
          ? emit(UserLoadedState((await userRepo.tryGetUser())!))
          : emit(FailedToUpdateUsernameState());
    }
  }
}
