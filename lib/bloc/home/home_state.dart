part of "home_bloc.dart";

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}

class UserLoadedState extends HomeState {
  final User user;
  UserLoadedState(this.user);
}

class FetchingUserState extends HomeState {}

class FailureLoadingUserState extends HomeState {}

class FailureUpdatingUsernameState extends HomeState {}
