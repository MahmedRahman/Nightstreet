import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_night_street/core/themes/text_styles.dart';

class RoundedTextField extends GetView {
  RoundedTextField({
    required this.labelText,
    this.controller,
    this.backGroundColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.borderRadius = 32,
    this.onChanged,
  });

  final String? labelText;
  final TextEditingController? controller;
  final Color? backGroundColor;
  final Color? borderColor;
  final double borderRadius;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        maxLines: 4,
        onChanged: onChanged,
        cursorColor: Color(0xffD8D8D8),
        decoration: InputDecoration(
          border: border(borderColor!),
          enabledBorder: border(borderColor!),
          focusedBorder: border(borderColor!),
          hintText: labelText,
          hintStyle: TextStyles.font12regularGray,
          filled: true,
          fillColor: backGroundColor,
        ),
      ),
    );
  }

  OutlineInputBorder border(Color borderColor) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 0,
        color: borderColor,
      ),
      borderRadius: BorderRadius.circular(
        borderRadius,
      ),
    );
  }
}
