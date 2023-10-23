import 'package:assignment/Features/Authentication/Presentations/Bloc/login/login_bloc.dart';
import 'package:assignment/Features/SplashScreen/Bloc/splash_bloc.dart';
import 'package:assignment/core/utils/theme.dart';
import 'package:assignment/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'get_init.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setUp();
  runApp(const MyApp());
}

//....................................APP Router  ................................
final appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) =>
              LoginBloc(di.getIt()), // Create your LoginBloc here
        ),
        BlocProvider<SplashBloc>(
          create: (context) => SplashBloc(di.getIt()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.data,
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
        ),
      ),
    );
  }
}
