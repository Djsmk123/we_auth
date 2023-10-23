import 'package:assignment/Features/HomeScreen/home_screen.dart';
import 'package:assignment/Features/SplashScreen/Bloc/splash_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'Splash')
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashBloc>(context).add(SplashEventCheckAuth());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoadingSuccess) {
            if (state.isAuthenticated) {
              context.router.replaceNamed('/home');
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (builder) => const HomeScreen()));
            }
          }
        },
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
