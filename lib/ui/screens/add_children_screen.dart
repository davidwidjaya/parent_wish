import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_wish/ui/themes/color.dart';
import 'package:parent_wish/widgets/input_dropdown.dart';
import 'package:parent_wish/widgets/input_field.dart';

class AddChildrenScreen extends StatefulWidget {
  const AddChildrenScreen({super.key});

  @override
  State<AddChildrenScreen> createState() => _AddChildrenScreenState();
}

class _AddChildrenScreenState extends State<AddChildrenScreen> {
  final userIdController = TextEditingController();
  String? selectedAge;
  String? selectedSchoolDays;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter your children`s detail',
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: AppColors.blue500, // Blue color
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
            ),
          ),
          // Top blue background
          Positioned(
            child: Container(
              height: 250.h,
              color: AppColors.blue500,
            ),
          ),

          // Avatar & Camera Icon (centered)
          Positioned(
            top: 60.h, // Adjust vertical position as needed
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage:
                        const AssetImage('assets/images/profile-img.png'),
                    backgroundColor: Colors.grey[300],
                  ),

                  // Camera icon (bottom right)
                  Positioned(
                    top: 60.h,
                    left: 55.w,
                    child: IconButton.filled(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/icons/photo-camera.png',
                        width: 20.w,
                        height: 20.h,
                        color: AppColors.blue500,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.white,
                        shape: const CircleBorder(),
                        padding: EdgeInsets.all(6.r),
                        minimumSize: Size(32.w, 32.h),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // White form container below avatar
          Positioned(
            top: 100.h, // Adjust based on avatar position
            left: 24.w,
            right: 24.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 👉 Replace with your actual input fields
                  InputField(
                    label: 'Full Name',
                    hintText: 'Enter name',
                    controller: userIdController,
                  ),
                  SizedBox(height: 16.h),
                  InputField(
                    label: 'Gender',
                    hintText: 'Enter gender',
                    controller: userIdController,
                  ),
                  SizedBox(height: 16.h),
                  InputDropdown<String>(
                    label: 'Age Category',
                    hintText: 'Select age range',
                    value: selectedAge,
                    items: const [
                      DropdownMenuItem(value: '3-5', child: Text('3 to 5')),
                      DropdownMenuItem(value: '6-8', child: Text('6 to 8')),
                      DropdownMenuItem(value: '10-12', child: Text('10 to 12')),
                      DropdownMenuItem(value: '13-18', child: Text('13 to 18')),
                    ],
                    onChanged: (value) => setState(() => selectedAge = value),
                  ),
                  SizedBox(height: 16.h),
                  InputDropdown<String>(
                    label: 'School Days',
                    hintText: 'Select school days',
                    value: selectedSchoolDays,
                    items: const [
                      DropdownMenuItem(value: 'winter', child: Text('Winter')),
                      DropdownMenuItem(value: 'summer', child: Text('Summer')),
                    ],
                    onChanged: (value) =>
                        setState(() => selectedSchoolDays = value),
                  ),

                  SizedBox(height: 24.h),
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
                          'Save Children',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
