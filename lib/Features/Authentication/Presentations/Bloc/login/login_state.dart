part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  final LoginStates state;
  const LoginLoading(this.state);

  @override
  List<Object?> get props => [state];
}

class FailureLogin extends LoginState {
  final LoginStates state;
  final Failure failure;
  const FailureLogin(this.state, this.failure);

  @override
  List<Object?> get props => [state, failure];
}

class LoginSuccess extends LoginState {
  final LoginStates state;

  const LoginSuccess({required this.state});

  @override
  List<Object?> get props => [state];
}

enum LoginStates {
  signIn,
  forgotPassword,
  signup,
}
