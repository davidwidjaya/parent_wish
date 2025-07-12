import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parent_wish/bloc/auth_bloc/auth_bloc.dart';
import 'package:parent_wish/bloc/bloc_exports.dart';
import 'package:parent_wish/ui/themes/color.dart';
import 'package:parent_wish/utils/routers.dart';
import 'package:parent_wish/widgets/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Google Sign-In successful!')),
            );
            navigator.pushReplacementNamed(
              AppRouter.completeProfile,
            );
          } else {
            //Auth manual
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
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 25.h, left: 24.w, right: 24.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray900,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        'Start learning with create your account',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.gray400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: InputField(
                        label: 'User ID',
                        hintText: 'Create your User ID',
                        prefixIconAsset: 'assets/icons/profile.png',
                        controller: userIdController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'User ID is required'
                            : null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: InputField(
                        label: 'Email',
                        hintText: 'Enter your email',
                        prefixIconAsset: 'assets/icons/sms.png',
                        controller: emailController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Email is required'
                            : null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: InputField(
                        label: 'Password',
                        hintText: 'Create your password',
                        prefixIconAsset: 'assets/icons/lock.png',
                        suffixIconAsset: 'assets/icons/eye.png',
                        controller: passwordController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Password is required'
                            : null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthRegisterManual(
                                      username: userIdController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                            }
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.blue500,
                            foregroundColor: AppColors.white,
                            padding: EdgeInsets.symmetric(vertical: 17.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Or using other method',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.gray500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.white,
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
                            context.read<AuthBloc>().add(AuthRegisterGoogle());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                    // Facebook button (not wired up yet)
                    Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.white,
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
                            // Handle Facebook Sign Up logic
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                      padding: EdgeInsets.only(top: 32.h),
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
                          Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.login,
                                );
                              },
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
      ),
    );
  }
}
