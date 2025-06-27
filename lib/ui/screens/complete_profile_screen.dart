import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_wish/ui/themes/color.dart';
import 'package:parent_wish/widgets/input_dropdown.dart';
import 'package:parent_wish/widgets/input_field.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final userIdController = TextEditingController();
  String? selectedParentType;
  String? selectedTimezone;

  static const List<DropdownMenuItem<String>> timezoneItems = [
    DropdownMenuItem(
        value: "Pacific/Midway", child: Text("(UTC-11:00) Pacific/Midway")),
    DropdownMenuItem(
        value: "America/Adak", child: Text("(UTC-10:00) America/Adak")),
    DropdownMenuItem(
        value: "Pacific/Honolulu", child: Text("(UTC-10:00) Pacific/Honolulu")),
    DropdownMenuItem(
        value: "America/Anchorage",
        child: Text("(UTC-09:00) America/Anchorage")),
    DropdownMenuItem(
        value: "America/Los_Angeles",
        child: Text("(UTC-08:00) America/Los_Angeles")),
    DropdownMenuItem(
        value: "America/Denver", child: Text("(UTC-07:00) America/Denver")),
    DropdownMenuItem(
        value: "America/Chicago", child: Text("(UTC-06:00) America/Chicago")),
    DropdownMenuItem(
        value: "America/New_York", child: Text("(UTC-05:00) America/New_York")),
    DropdownMenuItem(
        value: "America/Caracas", child: Text("(UTC-04:00) America/Caracas")),
    DropdownMenuItem(
        value: "America/Santiago", child: Text("(UTC-04:00) America/Santiago")),
    DropdownMenuItem(
        value: "America/St_Johns", child: Text("(UTC-03:30) America/St_Johns")),
    DropdownMenuItem(
        value: "America/Argentina/Buenos_Aires",
        child: Text("(UTC-03:00) Buenos Aires")),
    DropdownMenuItem(
        value: "Atlantic/South_Georgia",
        child: Text("(UTC-02:00) South Georgia")),
    DropdownMenuItem(
        value: "Atlantic/Azores", child: Text("(UTC-01:00) Azores")),
    DropdownMenuItem(value: "UTC", child: Text("(UTC+00:00) UTC")),
    DropdownMenuItem(value: "Europe/London", child: Text("(UTC+00:00) London")),
    DropdownMenuItem(value: "Europe/Paris", child: Text("(UTC+01:00) Paris")),
    DropdownMenuItem(value: "Europe/Berlin", child: Text("(UTC+01:00) Berlin")),
    DropdownMenuItem(
        value: "Europe/Istanbul", child: Text("(UTC+03:00) Istanbul")),
    DropdownMenuItem(
        value: "Africa/Nairobi", child: Text("(UTC+03:00) Nairobi")),
    DropdownMenuItem(value: "Asia/Dubai", child: Text("(UTC+04:00) Dubai")),
    DropdownMenuItem(value: "Asia/Karachi", child: Text("(UTC+05:00) Karachi")),
    DropdownMenuItem(value: "Asia/Dhaka", child: Text("(UTC+06:00) Dhaka")),
    DropdownMenuItem(value: "Asia/Jakarta", child: Text("(UTC+07:00) Jakarta")),
    DropdownMenuItem(
        value: "Asia/Singapore", child: Text("(UTC+08:00) Singapore")),
    DropdownMenuItem(value: "Asia/Tokyo", child: Text("(UTC+09:00) Tokyo")),
    DropdownMenuItem(
        value: "Australia/Sydney", child: Text("(UTC+10:00) Sydney")),
    DropdownMenuItem(
        value: "Pacific/Auckland", child: Text("(UTC+12:00) Auckland")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complete Profile',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.blue500,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          color: AppColors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: [
              // Background
              Positioned.fill(
                child: Container(
                  color: Colors.white,
                ),
              ),
              // Blue header background
              Positioned(
                child: Container(
                  height: 250.h,
                  color: AppColors.blue500,
                ),
              ),
              // Avatar and camera icon
              Positioned(
                top: 60.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage:
                            const AssetImage('assets/images/profile-img.png'),
                        backgroundColor: Colors.grey[300],
                      ),
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
              // Form
              Positioned(
                top: 200.h,
                left: 24.w,
                right: 24.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
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
                    children: [
                      InputField(
                        label: 'Full Name',
                        hintText: 'Enter name',
                        controller: userIdController,
                      ),
                      SizedBox(height: 16.h),
                      InputField(
                        label: 'Date of Birth',
                        hintText: 'Enter date of birth',
                        controller: userIdController,
                      ),
                      SizedBox(height: 16.h),
                      InputDropdown<String>(
                        label: 'Are You a?',
                        hintText: 'Select an option',
                        value: selectedParentType,
                        items: const [
                          DropdownMenuItem(
                            value: 'mother',
                            child: Text('Mother'),
                          ),
                          DropdownMenuItem(
                            value: 'father',
                            child: Text('Father'),
                          ),
                        ],
                        onChanged: (value) =>
                            setState(() => selectedParentType = value),
                      ),
                      SizedBox(height: 16.h),
                      InputDropdown<String>(
                        label: 'Time Zone',
                        hintText: 'Select your time zone',
                        value: selectedTimezone,
                        items: timezoneItems,
                        onChanged: (value) =>
                            setState(() => selectedTimezone = value),
                      ),
                      SizedBox(height: 74.h), // Gives space before the button
                      SizedBox(
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
                            'Next',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Add bottom padding space if needed
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
