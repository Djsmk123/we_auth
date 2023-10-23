// ignore_for_file: depend_on_referenced_packages

import 'package:assignment/Features/Authentication/Data/source/auth_repo_impl.dart';
import 'package:assignment/Features/Authentication/Presentations/Bloc/login/login_bloc.dart';
import 'package:assignment/core/Network/network.dart';
import 'package:assignment/core/utils/parser.dart';
import 'package:assignment/core/utils/stroage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart' as http_logger;

import 'core/utils/loggers.dart';

final getIt = GetIt.instance;

Future<void> setUp() async {
  // Add 'void' to the setUp function declaration
  // Bloc
  getIt.registerFactory(() => LoginBloc(getIt<
      AuthRepoImpl>())); // Use getIt<AuthRepoImpl>() to retrieve the AuthRepoImpl instance

  // Repositories
  getIt.registerLazySingleton<AuthRepoImpl>(() => AuthRepoImpl(
      networkServiceImpl: getIt(),
      storageService: getIt())); // Register AuthRepoImpl

  //! External
  const FlutterSecureStorage storage = FlutterSecureStorage();
  getIt.registerLazySingleton(() => storage);

  getIt.registerLazySingleton(() => http.Client());
  final InternetConnection checkerPlus = InternetConnection();
  getIt.registerLazySingleton(() => checkerPlus);
  Logger logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2, // Number of method calls to be displayed
        errorMethodCount: 8, // Number of method calls if stacktrace is provided
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );
  getIt.registerLazySingleton(() => logger);
  http_logger.HttpWithMiddleware httpWithMiddleware =
      http_logger.HttpWithMiddleware.build(
          requestTimeout: const Duration(seconds: 30),
          middlewares: [HttpLogger(getIt<Logger>())]);
  getIt.registerLazySingleton(() => httpWithMiddleware);

  // Core

  getIt.registerLazySingleton<NetworkServiceImpl>(
      () => NetworkServiceImpl(getIt(), getIt()));
  getIt.registerLazySingleton<JsonObjectUtils>(
      () => JsonObjectUtils()); // Register JsonObjectUtils

  getIt.registerLazySingleton<StorageService>(
      () => StorageService(getIt<FlutterSecureStorage>()));
  // Use getIt<FlutterSecureStorage>() to retrieve the FlutterSecureStorage instance
  getIt.registerLazySingleton<HttpLogger>(() => HttpLogger(getIt<Logger>()));
}
