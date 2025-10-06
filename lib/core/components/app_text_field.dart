import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:workspace/core/utils/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.onTap,
    this.maxLine,
    this.hintText,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.radius = 16,
    this.textInputType,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    required this.controller,
  });

  final int? maxLine;
  final bool enabled;
  final bool readOnly;
  final double radius;
  final bool obscureText;
  final String? hintText;
  final Function()? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      maxLines: maxLine,
      readOnly: readOnly,
      style: _textStyle(),
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      cursorColor: AppColors.black,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        hintMaxLines: 1,
        enabled: enabled,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: _buildBorder(),
        labelStyle: _textStyle(),
        hintStyle: _hintTextStyle(),
        enabledBorder: _buildBorder(),
        focusedBorder: _buildBorder(),
        errorStyle: _errorTextStyle(),
        disabledBorder: _buildBorder(),
        contentPadding: const EdgeInsets.fromLTRB(0, 15, 18, 15),
        prefix:
            prefixIcon == null
                ? const Padding(padding: EdgeInsets.only(left: 20))
                : null,
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: AppColors.black.withAlpha(50)),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(color: enabled ? AppColors.black : AppColors.grey);
  }

  TextStyle _hintTextStyle() => TextStyle(color: AppColors.black);

  TextStyle _errorTextStyle() {
    return const TextStyle(
      fontSize: 12,
      color: AppColors.red,
      fontWeight: FontWeight.w600,
    );
  }
}

class PreFixIcon extends StatelessWidget {
  const PreFixIcon({super.key, this.onTap, required this.image});
  final VoidCallback? onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 18,
        height: 18,
        child: Center(child: SvgPicture.asset(image, width: 18, height: 18)),
      ),
    );
  }
}
