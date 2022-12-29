part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}

class UserLoadedState extends HomeState {
  final User user;
  UserLoadedState(this.user);
}

class FetchingUserState extends HomeState {}

class FailedToLoadUserState extends HomeState {}

class FailedToUpdateUsernameState extends HomeState {}

class ErrorState extends HomeState {
  final String msg;

  ErrorState(this.msg);
}
