import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_wish/ui/themes/color.dart';

class InputField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData? prefixIcon;
  final String? prefixIconAsset;
  final IconData? suffixIcon;
  final String? suffixIconAsset;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const InputField({
    super.key,
    required this.label,
    required this.hintText,
    this.prefixIcon,
    this.prefixIconAsset,
    this.suffixIcon,
    this.suffixIconAsset,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = true;

  Widget? _buildPrefixIcon() {
    if (widget.prefixIconAsset != null) {
      return Padding(
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        child: Image.asset(
          widget.prefixIconAsset!,
          width: 24.w,
          height: 24.h,
          fit: BoxFit.contain,
        ),
      );
    } else if (widget.prefixIcon != null) {
      return Icon(widget.prefixIcon, color: AppColors.gray400, size: 24.w);
    }
    return null;
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: AppColors.gray400,
          size: 24.w,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    } else if (widget.suffixIconAsset != null) {
      return Padding(
        padding: EdgeInsets.all(12.w),
        child: Image.asset(
          widget.suffixIconAsset!,
          width: 24.w,
          height: 24.w,
          fit: BoxFit.contain,
        ),
      );
    } else if (widget.suffixIcon != null) {
      return Icon(widget.suffixIcon, color: AppColors.gray400, size: 24.w);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
          decoration: BoxDecoration(
            color: AppColors.gray50,
            borderRadius: BorderRadius.circular(15.w),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPassword ? _obscureText : false,
            validator: widget.validator,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: AppColors.gray400,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: _buildPrefixIcon(),
              suffixIcon: _buildSuffixIcon(),
            ),
          ),
        ),
      ],
    );
  }
}
