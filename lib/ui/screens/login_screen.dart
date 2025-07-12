import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_wish/bloc/auth_bloc/auth_bloc.dart';
import 'package:parent_wish/bloc/bloc_exports.dart';
import 'package:parent_wish/ui/themes/color.dart';
import 'package:parent_wish/utils/routers.dart';
import 'package:parent_wish/widgets/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final String? token;
  final bool? showForgotPasswordSheet;

  const LoginScreen({
    super.key,
    this.token,
    this.showForgotPasswordSheet = false,
  });

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formCreatePasswordKey = GlobalKey<FormState>();

  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final forgotEmailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _hasShownForgotPasswordSheet = false;
  bool _isProcessingDeepLink = false; // Add this flag

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleDeepLink();
    });
  }

  void _handleDeepLink() async {
    // Prevent multiple executions
    if (_isProcessingDeepLink || _hasShownForgotPasswordSheet) return;

    _isProcessingDeepLink = true;

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null && args['showForgotPasswordSheet'] == true) {
      _hasShownForgotPasswordSheet = true;

      try {
        final prefs = await SharedPreferences.getInstance();
        final forgotEmail = prefs.getString('forgot_email');

        if (!mounted) return;

        await showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: true,
          builder: (context) => CreateNewPasswordBottomSheet(
            formKey: _formCreatePasswordKey,
            newPasswordController: newPasswordController,
            confirmPasswordController: confirmPasswordController,
            code: widget.token ?? '',
            email: forgotEmail ?? '',
          ),
        );
      } catch (e) {
        print('Error showing forgot password sheet: $e');
      } finally {
        _isProcessingDeepLink = false;
      }
    } else {
      _isProcessingDeepLink = false;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null &&
        args['showForgotPasswordSheet'] == true &&
        !_hasShownForgotPasswordSheet) {
      _hasShownForgotPasswordSheet = true;

      final currentContext = context; // Capture context before async gap

      Future.delayed(const Duration(milliseconds: 300), () async {
        if (!mounted) return;

        final prefs = await SharedPreferences.getInstance();
        final forgotEmail = prefs.getString('forgot_email');

        if (!mounted) return; // Check again after async

        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          context: currentContext, // Use captured context
          isScrollControlled: true,
          builder: (_) => CreateNewPasswordBottomSheet(
            formKey: _formCreatePasswordKey,
            newPasswordController: newPasswordController,
            confirmPasswordController: confirmPasswordController,
            code: widget.token ?? '',
            email: forgotEmail ?? '',
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final token = args?['token'];
    final shouldShowSheet = args?['showForgotPasswordSheet'] == true;

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
        } else if (state is AuthForgotPasswordSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Forgot password sent to your email!'),
            ),
          );
        } else if (state is AuthVerifyForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password successfully changed!'),
            ),
          );
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
                          InkWell(
                            onTap: () {
                              final _formForgotKey = GlobalKey<FormState>();
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.r)),
                                ),
                                context: context,
                                isScrollControlled: true,
                                builder: (_) => ForgotPasswordBottomSheet(
                                    formKey: _formForgotKey,
                                    controller: forgotEmailController),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blue500,
                              ),
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              //do logic here
                              context.read<AuthBloc>().add(
                                    AuthLoginManual(
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
                            context.read<AuthBloc>().add(AuthRegisterGoogle());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // ⬅️ Center icon + text
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image.asset(
                                'assets/icons/google.png',
                                height: 24,
                                width: 24,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Sign In with Google',
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
                            mainAxisAlignment: MainAxisAlignment
                                .center, // ⬅️ Center icon + text
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image.asset(
                                'assets/icons/facebook.png',
                                height: 24,
                                width: 24,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Sign In with Facebook',
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
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.register,
                                );
                              },
                              child: Text(
                                'Create Account',
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

class CreateNewPasswordBottomSheet extends StatelessWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final String code;
  final String email;
  final GlobalKey<FormState> formKey;

  const CreateNewPasswordBottomSheet({
    super.key,
    required this.formKey,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.code,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 60.w,
                height: 6.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.gray150,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              'Create New Password',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray900),
            ),
            SizedBox(height: 4.h),
            Text(
              'Enter your new password',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray400),
            ),
            SizedBox(height: 30.h),
            InputField(
              label: 'Password',
              hintText: 'Input your new password',
              prefixIconAsset: 'assets/icons/lock.png',
              suffixIconAsset: 'assets/icons/eye.png',
              controller: newPasswordController,
              validator: (value) => value == null || value.isEmpty
                  ? 'Password is required'
                  : null,
            ),
            SizedBox(height: 20.h),
            InputField(
                label: 'Confirm Password',
                hintText: 'Input your confirm password',
                prefixIconAsset: 'assets/icons/lock.png',
                suffixIconAsset: 'assets/icons/eye.png',
                controller: confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm password is required';
                  }
                  if (value != newPasswordController.text) {
                    return 'Confirm password do not match';
                  }
                }),
            SizedBox(height: 43.h),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          AuthVerifyForgotPassword(
                            code: code,
                            email: email,
                            newPassword: newPasswordController.text,
                          ),
                        );
                    Navigator.pop(context);
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.blue500,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(vertical: 17.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: Text('Change Password',
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordBottomSheet extends StatelessWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  // final _formKey = GlobalKey<FormState>();

  ForgotPasswordBottomSheet({
    super.key,
    required this.controller,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 60.w,
                height: 6.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.gray150,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              'Forgot Password',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray900),
            ),
            SizedBox(height: 4.h),
            Text(
              'Enter your mail',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray400),
            ),
            SizedBox(height: 30.h),
            InputField(
              label: 'Email',
              hintText: 'Enter your email',
              prefixIconAsset: 'assets/icons/sms.png',
              controller: controller,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Email is required' : null,
            ),
            SizedBox(height: 43.h),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('forgot_email', controller.text);

                    context.read<AuthBloc>().add(
                          AuthForgotPassword(email: controller.text),
                        );
                    Navigator.pop(context);
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.blue500,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(vertical: 17.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: Text('Send Code',
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
