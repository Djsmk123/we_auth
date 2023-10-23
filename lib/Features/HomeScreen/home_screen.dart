import 'package:assignment/Features/Authentication/Data/models/usermodel.dart';
import 'package:assignment/Features/Authentication/Data/source/auth_repo_impl.dart';

import 'package:flutter/material.dart';

import '../../get_init.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Usermodel? user = getIt<AuthRepoImpl>().user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello ${user?.userName}"),
        ],
      ),
    );
  }
}
