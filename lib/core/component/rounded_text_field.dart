import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:app_night_street/core/themes/text_styles.dart';

class RoundedTextField extends GetView {
  RoundedTextField({
    required this.labelText,
    this.controller,
    this.backGroundColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.borderRadius = 32,
    this.hideBorder = false,
    this.onChanged,
    this.maxLines = 4,
    this.suffixIcon,
  });

  final int maxLines;
  final String? labelText;
  final Color? borderColor;
  final double borderRadius;
  final Color? backGroundColor;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool hideBorder;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onChanged: onChanged,
      cursorColor: Color(0xffD8D8D8),
      decoration: InputDecoration(
        border: hideBorder ? InputBorder.none : border(borderColor!),
        enabledBorder: hideBorder ? InputBorder.none : border(borderColor!),
        focusedBorder: hideBorder ? InputBorder.none : border(borderColor!),
        hintText: labelText,
        hintStyle: TextStyles.font12regularGray,
        filled: true,
        fillColor: backGroundColor,
        suffixIcon: suffixIcon,
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
