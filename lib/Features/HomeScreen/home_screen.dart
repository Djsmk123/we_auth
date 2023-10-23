// ignore_for_file: use_build_context_synchronously

import 'package:assignment/Features/Authentication/Data/models/usermodel.dart';
import 'package:assignment/Features/Authentication/Data/source/auth_repo_impl.dart';
import 'package:assignment/Features/Authentication/Presentations/Pages/authetication_page.dart';
import 'package:assignment/core/utils/color_config.dart';
import 'package:assignment/core/widgets/custom_snack_bar.dart';
import 'package:assignment/core/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hello ${user?.username}"),
            SizedBox(
              height: 10.h,
            ),
            CustomRoundedButton(
                onTap: () async {
                  final res = await getIt<AuthRepoImpl>().logout();
                  if (res == null) {
                    Navigator.popUntil(context, (route) => false);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const AuthticationPage()));
                  } else {
                    showSnackBar(
                        isSuccess: false, msg: res.message, context: context);
                  }
                },
                backgroundColor: ColorConfig.primaryColor,
                child: const Text("Logout"))
          ],
        ),
      ),
    );
  }
}
