import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parent_wish/ui/themes/color.dart';

class InputOTP extends StatefulWidget {
  final int length;
  final Function(String) onCompleted;
  final Function(String)? onChanged;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? fillColor;
  final double? borderRadius;
  final double? spacing;

  const InputOTP({
    Key? key,
    this.length = 5,
    required this.onCompleted,
    this.onChanged,
    this.width = 60,
    this.height = 70,
    this.textStyle,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.fillColor,
    this.borderRadius = 12,
    this.spacing = 6,
  }) : super(key: key);

  @override
  State<InputOTP> createState() => _InputOTPState();
}

class _InputOTPState extends State<InputOTP> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  String _code = '';

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.length,
      (index) => FocusNode(),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && value.length == 1) {
      _controllers[index].text = value;

      // Move to next field
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else if (value.isEmpty) {
      _controllers[index].text = '';
    }

    // Update the complete code
    _updateCode();
  }

  void _onKeyEvent(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (_controllers[index].text.isEmpty && index > 0) {
          // Move to previous field and clear it
          _focusNodes[index - 1].requestFocus();
          _controllers[index - 1].clear();
          _updateCode();
        }
      }
    }
  }

  void _updateCode() {
    _code = _controllers.map((controller) => controller.text).join();

    if (widget.onChanged != null) {
      widget.onChanged!(_code);
    }

    if (_code.length == widget.length) {
      widget.onCompleted(_code);
    }
  }

  Widget _buildCodeField(int index) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) => _onKeyEvent(event, index),
        child: TextFormField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: widget.textStyle ??
              const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: widget.fillColor ?? AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              borderSide: BorderSide(
                color: widget.enabledBorderColor ?? AppColors.gray300,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              borderSide: BorderSide(
                color: widget.enabledBorderColor ?? AppColors.gray300,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              borderSide: BorderSide(
                color: widget.focusedBorderColor ?? AppColors.blue500,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) => _onChanged(value, index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.length,
        (index) => Padding(
          padding: EdgeInsets.only(
            right: index < widget.length - 1 ? widget.spacing ?? 16 : 0,
          ),
          child: _buildCodeField(index),
        ),
      ),
    );
  }
}
