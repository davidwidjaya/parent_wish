import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parent_wish/bloc/auth_bloc/auth_bloc.dart';
import 'package:parent_wish/bloc/bloc_exports.dart';
import 'package:parent_wish/ui/themes/color.dart';
import 'package:parent_wish/utils/routers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        final navigator =
            Navigator.of(context); // capture navigator before await

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AuthAuthenticated) {
          if (state.isGoogle == true) {
            //Auth with Google
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var userString = prefs.getString('user') ?? '{}';
            var user = jsonDecode(userString);
            print(user);

            if (user['step'] == 'step_verif_code') {
              navigator.pushReplacementNamed(
                AppRouter.verificationEmail,
              );
            } else if (user['step'] == 'step_edit_profile') {
              navigator.pushReplacementNamed(
                AppRouter.completeProfile,
              );
            } else if (user['step'] == 'step_completed') {
              navigator.pushReplacementNamed(
                AppRouter.home,
              );
            }
          }
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/background-blur.png',
                fit: BoxFit.cover,
              ),
            ),
            // Foreground content
            Positioned.fill(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: 136.h, left: 24.w, right: 24.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Welcome to ParentWish',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.gray900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 33.h),
                          child: Text(
                            'Your companion in becoming the best parent for your children',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 56.h),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.white,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(
                                    color: AppColors.gray300,
                                    width: 1,
                                  ),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                context
                                    .read<AuthBloc>()
                                    .add(AuthRegisterGoogle());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset(
                                    'assets/icons/google.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    'Sign Up with Google',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.gray900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.white,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(
                                    color: AppColors.gray300,
                                    width: 1,
                                  ),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Facebook login coming soon!'),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset(
                                    'assets/icons/facebook.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    'Sign Up with Facebook',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.gray900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.white,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(
                                    color: AppColors.gray300,
                                    width: 1,
                                  ),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.register,
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset(
                                    'assets/icons/gmail.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    'Sign Up with Email',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.gray900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 71.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Have an account?',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.gray500,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRouter.login,
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 3.w),
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.blue500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
