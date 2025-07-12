import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parent_wish/bloc/auth_bloc/auth_bloc.dart';
import 'package:parent_wish/bloc/task_bloc/task_bloc.dart';
import 'package:parent_wish/ui/themes/color.dart';
import 'package:parent_wish/widgets/input_dropdown.dart';
import 'package:parent_wish/widgets/input_field.dart';
import 'package:permission_handler/permission_handler.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final taskNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final videoController = TextEditingController();

  String? selectedAge;
  String? selectedFrequently;

  void _clearData() {
    taskNameController.text = "";
    descriptionController.text = "";
    videoController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskLoading) {
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (_) => const Center(child: CircularProgressIndicator()),
          // );
        } else if (state is TaskAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Task added!'),
            ),
          );
        } else if (state is TaskError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add New Task',
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
                  top: 19.h,
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
                            label: 'Task Name',
                            hintText: 'Enter task name',
                            controller: taskNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter task name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          InputField(
                            label: 'Description',
                            hintText: 'Enter description',
                            controller: descriptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter description';
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
                            label: 'Frequently',
                            hintText: 'Select frequently',
                            value: selectedFrequently,
                            items: const [
                              DropdownMenuItem(
                                value: 'daily',
                                child: Text('Daily'),
                              ),
                              DropdownMenuItem(
                                value: 'weekly',
                                child: Text('Weekly'),
                              ),
                              DropdownMenuItem(
                                value: 'monthly',
                                child: Text('Monthly'),
                              ),
                            ],
                            onChanged: (value) =>
                                setState(() => selectedFrequently = value),
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(height: 16.h),
                          InputField(
                            label: 'Video URL',
                            hintText: 'Enter video url',
                            controller: videoController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter video URL';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 23.h),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print('SUBMITTING: ');
                                  print(taskNameController.text);
                                  print(descriptionController.text);
                                  print(selectedAge);
                                  print(selectedFrequently);
                                  print(videoController.text);
                                  context.read<TaskBloc>().add(TaskAdd(
                                        taskName: taskNameController.text,
                                        desc: descriptionController.text,
                                        age: selectedAge ?? '',
                                        frequently: selectedFrequently ?? '',
                                        videoURL: videoController.text,
                                      ));

                                  _clearData();
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
                                'Save Custom Task',
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
