import 'package:assignment/Features/Authentication/Presentations/Bloc/login/login_bloc.dart';
import 'package:assignment/core/utils/color_config.dart';
import 'package:assignment/core/widgets/bouncing_widget.dart';
import 'package:assignment/core/widgets/custom_text_field.dart';
import 'package:assignment/core/widgets/rounded_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_snack_bar.dart';
import '../../../HomeScreen/home_screen.dart';

class AuthticationPage extends StatefulWidget {
  const AuthticationPage({super.key});

  @override
  State<AuthticationPage> createState() => _AuthticationPageState();
}

class _AuthticationPageState extends State<AuthticationPage> {
  bool isLogin = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool isLoading = false;
  bool passwordVisibility = true;

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          setState(() {
            isLoading = true;
          });
        }
        if (state is FailureLogin) {
          setState(() {
            isLoading = false;
          });
          showSnackBar(
              context: context, isSuccess: false, msg: state.failure.message);
        }
        if (state is LoginSuccess) {
          setState(() {
            isLoading = false;
          });
          showSnackBar(
              context: context,
              isSuccess: true,
              msg: state.state == LoginStates.signIn
                  ? "Login Success"
                  : "Account Created successfully");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (builder) => const HomeScreen()));
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (isLogin) {
              setState(() {
                isLogin = false;
              });
              return false;
            }
            return true;
          },
          child: Scaffold(
            body: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        "we",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -7,
                            shadows: const [
                              Shadow(color: Colors.blue, blurRadius: 5)
                            ],
                            fontSize: 50.sp),
                      )),

                      //Create account elements
                      Center(
                        child: Text(
                          !isLogin ? " Create account" : " Login",
                          style: TextStyle(
                              color: ColorConfig.primaryColor,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),

                      Center(
                        child: Text(
                          !isLogin
                              ? "Let's make it official"
                              : "Heyy,yor're back",
                          style: TextStyle(
                              color: ColorConfig.kGrayColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      if (!isLogin)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Stack(
                            children: [

                              CustomTextField(
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  labelText: "Full Name",
                                  validator: (value) {
                                    if (!isLogin && value!.isEmpty) {
                                      return "Name is Required";
                                    }
                                    return null;
                                  },
                                  hintText: "Name"),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: CustomTextField(
                            controller: usernameController,
                            keyboardType: TextInputType.name,
                            labelText: "Username",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Username is required";
                              }
                              return null;
                            },
                            hintText: "Enter username"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: CustomTextField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: passwordVisibility,
                            maxLines: 1,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisibility = !passwordVisibility;
                                });
                              },
                              icon: Icon(passwordVisibility
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            labelText: "Password",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password is required";
                              }
                              if (!isLogin && !isPasswordValid(value)) {
                                return "Password should contain at least 8 characters,one uppercase,one lowercase,one special character and one number";
                              }
                              return null;
                            },
                            hintText: "Enter username"),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: BouncingWidget(
                          onTap: () {
                            setState(() {
                              rememberMe = !rememberMe;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 20.h,
                                width: 20.w,
                                decoration: BoxDecoration(
                                    color: rememberMe
                                        ? Colors.blueAccent
                                        : Colors.grey,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 15.r,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Remember me",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomRoundedButton(
                        borderRadius: BorderRadius.circular(16.r),
                        backgroundColor: ColorConfig.primaryColor,
                        width: 0.9.sw,
                        onTap: !isLoading
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  if (isLogin) {
                                    BlocProvider.of<LoginBloc>(context).add(
                                        LoginPasswordBasedEvent(
                                            password:
                                                passwordController.text.trim(),
                                            username: usernameController.text
                                                .trim()));
                                  } else {
                                    BlocProvider.of<LoginBloc>(context).add(
                                        CreateNewUserEvent(
                                            password:
                                                passwordController.text.trim(),
                                            username:
                                                usernameController.text.trim(),
                                            name: nameController.text.trim()));
                                  }
                                }
                              }
                            : null,
                        child: !isLoading
                            ? Text(
                                isLogin ? "Login" : "Continue",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.sp),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      BouncingWidget(
                        onTap: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: isLogin
                                  ? "Don't have an account?"
                                  : "Already have an account?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                  text: isLogin ? " Create now" : " Login",
                                  style: TextStyle(
                                      color: ColorConfig.primaryColor,
                                      fontSize: 14.sp,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w500),
                                )
                              ])
                        ])),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool isPasswordValid(String password) {
    String pattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }
}
