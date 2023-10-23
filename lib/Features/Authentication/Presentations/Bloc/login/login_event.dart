part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginPasswordBasedEvent extends LoginEvent {
  final String password;
  final String username;

  const LoginPasswordBasedEvent({
    required this.password,
    required this.username,
  });
  @override
  List<Object?> get props => [password, username];
}

class CreateNewUserEvent extends LoginEvent {
  final String password;
  final String username;
  final String name;

  const CreateNewUserEvent(
      {required this.password, required this.username, required this.name});
  @override
  List<Object?> get props => [password, username, name];
}

class ResetPasswordEvent extends LoginEvent {
  final String email;
  const ResetPasswordEvent(this.email);
  @override
  List<Object?> get props => [];
}
