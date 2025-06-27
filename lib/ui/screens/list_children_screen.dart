import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_wish/bloc/auth_bloc/auth_bloc.dart';
import 'package:parent_wish/ui/themes/color.dart';

class ListChildrenScreen extends StatefulWidget {
  const ListChildrenScreen({super.key});

  @override
  State<ListChildrenScreen> createState() => _ListChildrenScreenState();
}

class _ListChildrenScreenState extends State<ListChildrenScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthListChildren());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Children',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp, size: 22.w),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AuthError) {
              return Center(child: Text(state.message));
            }

            if (state is AuthListChildrenFetched) {
              final children = state.children;

              if (children.isEmpty) {
                return const Center(child: Text('No children found.'));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 350.h,
                    child: ListView.separated(
                      itemCount: children.length,
                      itemBuilder: (context, index) {
                        final child = children[index];
                        return ChildItem(
                          name: child.fullname,
                          gender: child.gender,
                          age: child
                              .ageCategory, // or calculate based on birthdate if available
                          iconPath: 'assets/icons/man.png',
                          onDelete: () {
                            // add delete logic here
                          },
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/add_children');
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
                        'Add More Children',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 13.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Next step action
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        padding: EdgeInsets.symmetric(vertical: 17.h),
                        side: BorderSide(
                          color: AppColors.blue500,
                          width: 1.w,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blue500,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class ChildItem extends StatelessWidget {
  final String name;
  final String gender;
  final String age;
  final String iconPath;
  final VoidCallback onDelete;

  const ChildItem({
    super.key,
    required this.name,
    required this.gender,
    required this.age,
    required this.iconPath,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(75.r),
        border: Border.all(
          color: AppColors.gray300,
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                iconPath,
                width: 36.w,
                height: 36.h,
              ),
              SizedBox(width: 9.w),
              Text(
                '$name, $gender, $age',
                style: TextStyle(
                  color: AppColors.gray900,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onDelete,
            child: Image.asset(
              'assets/icons/trash.png',
              width: 23.w,
              height: 23.h,
            ),
          ),
        ],
      ),
    );
  }
}
