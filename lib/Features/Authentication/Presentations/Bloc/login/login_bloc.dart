import 'package:assignment/Features/Authentication/Data/source/auth_repo_impl.dart';
import 'package:assignment/core/Errors/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepoImpl authRepo;
  LoginBloc(this.authRepo) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginPasswordBasedEvent) {
        emit(const LoginLoading(LoginStates.signIn));
        final res = await authRepo.signIn(event.username, event.password);
        if (res.$1 != null) {
          emit(FailureLogin(LoginStates.signIn, res.$1!));
        } else {
          emit(const LoginSuccess(state: LoginStates.signIn));
        }
      }
      if (event is CreateNewUserEvent) {
        emit(const LoginLoading(LoginStates.signup));
        final res =
            await authRepo.signUp(event.username, event.password, event.name);
        if (res.$1 != null) {
          emit(FailureLogin(LoginStates.signup, res.$1!));
        } else {
          emit(const LoginSuccess(state: LoginStates.signup));
        }
      }
    });
  }
}
