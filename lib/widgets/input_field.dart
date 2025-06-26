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
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  Widget? _buildPrefixIcon() {
    Color iconColor = _isFocused ? AppColors.blue500 : AppColors.gray400;

    if (widget.prefixIconAsset != null) {
      return Padding(
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          child: Image.asset(
            widget.prefixIconAsset!,
            width: 24.w,
            height: 24.h,
            fit: BoxFit.contain,
          ),
        ),
      );
    } else if (widget.prefixIcon != null) {
      return Icon(widget.prefixIcon, color: iconColor, size: 24.w);
    }
    return null;
  }

  Widget? _buildSuffixIcon() {
    Color iconColor = _isFocused ? AppColors.blue500 : AppColors.gray400;

    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: iconColor,
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
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          child: Image.asset(
            widget.suffixIconAsset!,
            width: 24.w,
            height: 24.w,
            fit: BoxFit.contain,
          ),
        ),
      );
    } else if (widget.suffixIcon != null) {
      return Icon(widget.suffixIcon, color: iconColor, size: 24.w);
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
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPassword ? _obscureText : false,
            validator: widget.validator,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(
                  color: AppColors.blue500,
                  width: 1.w,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 14.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(
                  color: AppColors.gray300,
                  width: 1.w,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(
                  color: AppColors.gray300,
                  width: 1.w,
                ),
              ),
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
