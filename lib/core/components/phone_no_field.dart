import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNoField extends StatelessWidget {
  const PhoneNoField({
    super.key,
    this.hintText,
    this.onChanged,
    required this.controller,
  });
  final String? hintText;
  final Function(PhoneNumber)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      showCountryFlag: false,
      controller: controller,
      initialCountryCode: "BD",
      cursorColor: Colors.black,
      onChanged: (phone) {
        onChanged?.call(phone);
      },
      style: _textStyle(),
      dropdownTextStyle: _textStyle(),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        focusColor: Colors.red,
        hintStyle: _hintTextStyle(),
        labelStyle: _hintTextStyle(),
        errorStyle: _hintTextStyle(),
        helperStyle: _hintTextStyle(),
        border: _buildBorder(),
        errorBorder: _buildBorder(),
        focusedBorder: _buildBorder(),
        enabledBorder: _buildBorder(),
        contentPadding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
      ),
    );
  }

  OutlineInputBorder _buildBorder() => OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(10),
  );

  TextStyle _textStyle() {
    return const TextStyle(color: Colors.black);
  }

  TextStyle _hintTextStyle() {
    return const TextStyle(
      color: Colors.black,
      overflow: TextOverflow.ellipsis,
    );
  }
}
