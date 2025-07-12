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

class AddChildrenScreen extends StatefulWidget {
  const AddChildrenScreen({super.key});

  @override
  State<AddChildrenScreen> createState() => _AddChildrenScreenState();
}

class _AddChildrenScreenState extends State<AddChildrenScreen> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final genderController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String? selectedAge;
  String? selectedSchoolDays;

  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? startTimeDisplay;
  String? endTimeDisplay;
  String? startTimeApi;
  String? endTimeApi;

  File? profileImage;

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

          // context.read<AuthBloc>().add(AuthUploadImageProfile(file: file.path));
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

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
          startTimeDisplay = _formatTimeForDisplay(picked);
          startTimeApi = _formatTimeForApi(picked);
        } else {
          endTime = picked;
          endTimeDisplay = _formatTimeForDisplay(picked);
          endTimeApi = _formatTimeForApi(picked);
        }
      });
    }
  }

  String _formatTimeForDisplay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute$period';
  }

  String _formatTimeForApi(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }
        if (state is AuthChildrenAdded) {
          Navigator.pushNamed(context, '/list_children');

          // Navigator.pop(context); // Navigate back or to next screen
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Enter your children`s detail',
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
                Positioned.fill(child: Container(color: Colors.white)),
                Positioned(
                  child: Container(
                    height: 250.h,
                    color: AppColors.blue500,
                  ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputField(
                            label: 'Full Name',
                            hintText: 'Enter name',
                            controller: fullNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter full name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          InputField(
                            label: 'Gender',
                            hintText: 'Enter gender',
                            controller: genderController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter gender';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          InputDropdown<String>(
                            label: 'Age Category',
                            hintText: 'Select age range',
                            value: selectedAge,
                            items: const [
                              DropdownMenuItem(
                                  value: '3-5', child: Text('3 to 5')),
                              DropdownMenuItem(
                                  value: '6-8', child: Text('6 to 8')),
                              DropdownMenuItem(
                                  value: '10-12', child: Text('10 to 12')),
                              DropdownMenuItem(
                                  value: '13-18', child: Text('13 to 18')),
                            ],
                            onChanged: (value) =>
                                setState(() => selectedAge = value),
                          ),
                          SizedBox(height: 16.h),
                          InputDropdown<String>(
                            label: 'School Days',
                            hintText: 'Select school days',
                            value: selectedSchoolDays,
                            items: const [
                              DropdownMenuItem(
                                  value: 'winter', child: Text('Winter')),
                              DropdownMenuItem(
                                  value: 'summer', child: Text('Summer')),
                            ],
                            onChanged: (value) =>
                                setState(() => selectedSchoolDays = value),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'School Time',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray900,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _selectTime(context, true),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 16.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.gray300,
                                        width: 1.w,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.r),
                                        bottomLeft: Radius.circular(15.r),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      startTimeDisplay ?? '18:50PM',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: startTimeDisplay != null
                                            ? Colors.black87
                                            : Colors.grey.shade500,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Text(
                                'To',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _selectTime(context, false),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 16.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.gray300,
                                        width: 1.w,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15.r),
                                        bottomRight: Radius.circular(15.r),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      endTimeDisplay ?? '18:50PM',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: endTimeDisplay != null
                                            ? Colors.black87
                                            : Colors.grey.shade500,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 23.h),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (selectedAge == null ||
                                      selectedSchoolDays == null ||
                                      startTimeApi == null ||
                                      endTimeApi == null ||
                                      profileImage == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please complete all fields')),
                                    );
                                    return;
                                  }

                                  context.read<AuthBloc>().add(AuthAddChildren(
                                        fullname: fullNameController.text,
                                        gender: genderController.text,
                                        ageCategory: selectedAge!,
                                        schoolDay: selectedSchoolDays!,
                                        startSchoolTime: startTimeApi!,
                                        endSchoolTime: endTimeApi!,
                                        image: profileImage!.path,
                                      ));
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
                                'Save Children',
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
