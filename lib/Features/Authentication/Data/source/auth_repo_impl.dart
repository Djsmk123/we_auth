import 'package:assignment/Features/Authentication/Data/models/usermodel.dart';
import 'package:assignment/Features/Authentication/Domain/auth_repo.dart';
import 'package:assignment/core/Errors/failure.dart';
import 'package:assignment/core/Model/network_response.dart';
import 'package:assignment/core/Network/network.dart';
import 'package:assignment/core/utils/parser.dart';

import '../../../../core/utils/stroage.dart';

class AuthRepoImpl extends AuthRepo {
  final NetworkServiceImpl networkServiceImpl;
  final StorageService storageService;

  AuthRepoImpl({
    required this.networkServiceImpl,
    required this.storageService,
  });
  Usermodel? user;
  String? accessToken;
  @override
  Future<(Failure?, Usermodel?)> signIn(
      String username, String password) async {
    final res = await networkServiceImpl.post(endpoint: '/login', data: {
      'email': "$username@gmail.com",
      'password': password,
      'fcm_token': ""
    });
    return loginSignUpHelper(res);
  }

  Future<(Failure?, Usermodel?)> loginSignUpHelper(
      (Failure?, ApiResponseModel?) res) async {
    if (res.$1 != null) {
      return (res.$1, null);
    }
    accessToken = res.$2?.data['access_token'];
    JsonObjectUtils<Usermodel> utils = JsonObjectUtils<Usermodel>();
    (Failure?, Usermodel?) obj =
        utils.jsonToObject(() => Usermodel.fromJson(res.$2!.data['user']));
    if (obj.$1 != null) {
      return (obj.$1, null);
    }
    user = obj.$2;
    final s = await storageService.write('token', accessToken!);
    if (s != null) {
      return (s, null);
    }
    return (null, user);
  }

  @override
  Future<(Failure?, Usermodel?)> signUp(
      String username, String password, String name) async {
    final res = await networkServiceImpl.post(endpoint: '/signup', data: {
      'email': "$username@gmail.com",
      'password': password,
      'name': name,
      'fcm_token': ""
    });
    return loginSignUpHelper(res);
  }

  @override
  Future<(Failure?, Usermodel?)> getUser() async {
    final res = await networkServiceImpl.get(
        endpoint: '/get-user', headers: await getHeaderWithToken());
    if (res.$1 != null) {
      return (res.$1, null);
    }
    JsonObjectUtils<Usermodel> utils = JsonObjectUtils<Usermodel>();
    (Failure?, Usermodel?) obj =
        utils.jsonToObject(() => Usermodel.fromJson(res.$2!.data));
    if (obj.$1 != null) {
      return (obj.$1, null);
    }
    user = obj.$2;
    return (null, user);
  }

  @override
  Future<Failure?> logout() {
    accessToken = null;
    user = null;
    return storageService.deleteAll();
  }

  Future<(Failure?, String?)> getAccessToken() async {
    if (accessToken != null) {
      return (null, accessToken);
    }
    final res = await storageService.readStorage('token');

    if (res.$1 != null) {
      return (res.$1, null);
    }
    accessToken = res.$2;
    return (null, res.$2);
  }

  Future<Map<String, String>> getHeaderWithToken() async {
    var accessToken = await getAccessToken();
    var header = {
      'content-type': 'application/json',
      'authorization': 'Bearer ${accessToken.$2}'
    };

    return header;
  }
}
