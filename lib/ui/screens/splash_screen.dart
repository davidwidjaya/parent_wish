import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_wish/ui/themes/color.dart';
import 'package:parent_wish/utils/routers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background-blur.png',
              fit: BoxFit.cover,
            ),
          ),
          //Foreground content
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
                          width:
                              double.infinity, // ⬅️ Make the button full-width
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
                          width:
                              double.infinity, // ⬅️ Make the button full-width
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
                          width:
                              double.infinity, // ⬅️ Make the button full-width
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
                              Navigator.pushNamed(
                                context,
                                AppRouter.register,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // ⬅️ Center icon + text
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
    );
  }
}
