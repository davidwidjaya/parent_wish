import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_wish/bloc/auth_bloc/auth_bloc.dart';
import 'package:parent_wish/ui/themes/color.dart';
import 'package:parent_wish/utils/routers.dart';
import 'package:parent_wish/widgets/input_otp.dart';
import 'package:parent_wish/widgets/pulse_icon.dart';

class VerificationEmailScreen extends StatefulWidget {
  const VerificationEmailScreen({super.key});

  @override
  State<VerificationEmailScreen> createState() =>
      _VerificationEmailScreenState();
}

class _VerificationEmailScreenState extends State<VerificationEmailScreen> {
  String verificationCode = '';

  @override
  void initState() {
    super.initState();
    // Trigger sending the email verification code when screen loads
    context.read<AuthBloc>().add(AuthSendEmailVerificationCode());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AuthCodeSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Verification code sent to your email')),
          );
        } else if (state is AuthCodeVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Verification code successfully verified')),
          );
          Navigator.pushReplacementNamed(
            context,
            AppRouter.completeProfile,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Verification',
            style: TextStyle(
              color: AppColors.gray900,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            color: AppColors.gray900,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 25.h, left: 24.w, right: 24.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const PulseIcon(
                    imageAsset: 'assets/icons/sms-search.png',
                    primaryColor: Color(0xFF2196F3),
                    size: 120.0,
                    duration: Duration(milliseconds: 1500),
                  ),
                  Text(
                    'Verification Code',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      'We have sent the code verification to your email',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: InputOTP(
                      length: 4,
                      onCompleted: (code) {
                        // Handle when all 5 digits are entered
                        setState(() {
                          verificationCode = code;
                        });
                        print('Verification code: $code');
                      },
                      onChanged: (code) {
                        setState(() {
                          verificationCode = code;
                        });
                        print('Current code: $code');
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          print(verificationCode);
                          context.read<AuthBloc>().add(
                                AuthSubmitEmailVerificationCode(
                                  smsCode: verificationCode,
                                ),
                              );
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
                          'Submit',
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
                    padding: EdgeInsets.only(top: 32.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Didn’t receive the code?',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<AuthBloc>()
                                .add(AuthSendEmailVerificationCode());
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: Text(
                              'Resend',
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
    );
  }
}
