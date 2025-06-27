import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parent_wish/bloc/auth_bloc/auth_bloc.dart';
import 'package:parent_wish/ui/themes/color.dart';
import 'package:parent_wish/widgets/input_dropdown.dart';
import 'package:parent_wish/widgets/input_field.dart';
import 'package:permission_handler/permission_handler.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final fullnameController = TextEditingController();
  final dobController = TextEditingController();
  String? selectedParentType;
  String? selectedTimezone;
  File? profileImage;

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

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

  Future<void> _pickImage() async {
    final permissionStatus = await Permission.photos.request();

    if (permissionStatus.isGranted) {
      try {
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          final file = File(pickedFile.path);

          setState(() {
            profileImage = file;
          });

          // ignore: use_build_context_synchronously
          context.read<AuthBloc>().add(AuthUploadImageProfile(file: file.path));
        } else {
          print('User cancelled image selection.');
        }
      } catch (e) {
        print('Image picker error: $e');
      }
    } else {
      print('Permission denied to access gallery.');
    }
  }

  void _submitProfile() {
    if (_formKey.currentState?.validate() != true ||
        selectedParentType == null ||
        selectedTimezone == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields')),
      );
      return;
    }

    context.read<AuthBloc>().add(
          AuthCompleteProfile(
            fullname: fullnameController.text,
            dateOfBirth: dobController.text,
            parentType: selectedParentType!,
            timezone: selectedTimezone!,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthProfileCompleted) {
          Navigator.pushNamed(context, '/add_children');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Complete Profile',
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600)),
          backgroundColor: AppColors.blue500,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            color: AppColors.white,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Stack(
              children: [
                Positioned.fill(child: Container(color: Colors.white)),
                Positioned(
                  child: Container(height: 250.h, color: AppColors.blue500),
                ),
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
                          backgroundImage: profileImage != null
                              ? FileImage(profileImage!)
                              : const AssetImage(
                                      'assets/images/profile-img.png')
                                  as ImageProvider,
                          backgroundColor: Colors.grey[300],
                        ),
                        Positioned(
                          top: 60.h,
                          left: 55.w,
                          child: IconButton.filled(
                            onPressed: _pickImage,
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputField(
                            label: 'Full Name',
                            hintText: 'Enter name',
                            controller: fullnameController,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Full name is required'
                                : null,
                          ),
                          SizedBox(height: 16.h),
                          InputField(
                            label: 'Date of Birth',
                            hintText: 'Enter date of birth',
                            controller: dobController,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Date of birth is required'
                                : null,
                          ),
                          SizedBox(height: 16.h),
                          InputDropdown<String>(
                            label: 'Are You a?',
                            hintText: 'Select an option',
                            value: selectedParentType,
                            items: const [
                              DropdownMenuItem(
                                  value: 'mother', child: Text('Mother')),
                              DropdownMenuItem(
                                  value: 'father', child: Text('Father')),
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
                          SizedBox(height: 74.h),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: _submitProfile,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
