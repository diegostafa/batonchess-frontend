part of "home_bloc.dart";

@immutable
abstract class HomeEvent {}

class FetchUserEvent extends HomeEvent {}

class UpdateUsernameEvent extends HomeEvent {
  final String? newUsername;
  UpdateUsernameEvent(this.newUsername);
}
