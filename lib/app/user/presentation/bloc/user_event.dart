sealed class UserEvent {}

//getUsers
final class GetUsersEvent extends UserEvent {
  GetUsersEvent();
}

//logout
final class LogoutEvent extends UserEvent {
  LogoutEvent();
}
