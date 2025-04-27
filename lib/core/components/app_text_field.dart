import 'package:flutter/material.dart';
import 'package:workspace/core/utils/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.maxLine,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.radius = 6,
    this.textInputType,
    this.enabled = true,
    this.hasShadow = false,
    this.obscureText = false,
    required this.controller,
  });

  final int? maxLine;
  final bool enabled;
  final double radius;
  final bool hasShadow;
  final bool obscureText;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final TextInputType? textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      style: _textStyle(),
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      cursorColor: AppColors.black,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isDense: true,
        enabled: enabled,
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: _buildBorder(),
        hintStyle: _hintTextStyle(),
        labelStyle: _hintTextStyle(),
        enabledBorder: _buildBorder(),
        focusedBorder: _buildBorder(),
        disabledBorder: _buildBorder(),
        contentPadding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: const BorderSide(color: AppColors.grey),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(color: AppColors.black);
  }

  TextStyle _hintTextStyle() {
    return const TextStyle(
      color: AppColors.black,
      overflow: TextOverflow.ellipsis,
    );
  }
}
