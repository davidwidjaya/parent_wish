import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_wish/ui/themes/color.dart';
import 'package:parent_wish/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 25.h, left: 24.w, right: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login Account',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray900,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    'Please login with registered account',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray400,
                    ),
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
                  padding: EdgeInsets.only(top: 15.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blue500,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.blue500,
                        foregroundColor: AppColors.white,
                        padding: EdgeInsets.symmetric(vertical: 17.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Sign In',
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
                    width: double.infinity, // ⬅️ Make the button full-width
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h), // ⬅️ No horizontal padding
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
                        // Handle Google Sign Up logic
                      },
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // ⬅️ Center icon + text
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
                    width: double.infinity, // ⬅️ Make the button full-width
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h), // ⬅️ No horizontal padding
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
                        // Handle Google Sign Up logic
                      },
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // ⬅️ Center icon + text
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
                  padding: EdgeInsets.only(top: 32.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account?',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.gray500,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blue500,
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
    );
  }
}
