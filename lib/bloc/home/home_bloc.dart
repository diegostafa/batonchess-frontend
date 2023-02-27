import "package:batonchess/data/model/user/user.dart";
import "package:batonchess/data/repo/user_repository.dart";
import "package:bloc/bloc.dart";
import "package:meta/meta.dart";

part "home_event.dart";
part "home_state.dart";

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
    final u = await userRepo.getUser();
    if (u == null) {
      emit(FailedToLoadUserState());
      return;
    }
    emit(UserLoadedState(u));
  }

  Future<void> updateUsernameHandler(
    UpdateUsernameEvent e,
    Emitter<HomeState> emit,
  ) async {
    if (e.newUsername == null) {
      return;
    }
    emit(FetchingUserState());

    final updated = await userRepo.updateUsername(e.newUsername!);
    if (!updated) {
      emit(FailedToUpdateUsernameState());
      return;
    }

    emit(UserLoadedState((await userRepo.getUser())!));
  }
}
