import 'package:assignment/Features/Authentication/Data/models/usermodel.dart';
import 'package:assignment/core/Errors/failure.dart';

abstract class AuthRepo {
  Future<(Failure?, Usermodel?)> signIn(String username, String password);
  Future<(Failure?, Usermodel?)> signUp(
      String username, String password, String name);
  Future<(Failure?, Usermodel?)> getUser();
  Future<Failure?> logout();
}
