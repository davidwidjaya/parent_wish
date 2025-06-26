import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_wish/ui/themes/color.dart';

class InputDropdown<T> extends StatefulWidget {
  final String label;
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;

  const InputDropdown({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  State<InputDropdown<T>> createState() => _InputDropdownState<T>();
}

class _InputDropdownState<T> extends State<InputDropdown<T>> {
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = _isFocused ? AppColors.blue500 : AppColors.gray300;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.gray900,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: borderColor, width: 1.w),
          ),
          child: DropdownButtonFormField<T>(
            focusNode: _focusNode,
            value: widget.value,
            items: widget.items,
            onChanged: widget.onChanged,
            validator: widget.validator,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: _isFocused ? AppColors.blue500 : AppColors.gray400,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: AppColors.gray400,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.gray900,
            ),
          ),
        ),
      ],
    );
  }
}
