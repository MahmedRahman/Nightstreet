import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_night_street/core/themes/text_styles.dart';

class RoundedTextField extends GetView {
  RoundedTextField({
    this.controller,
    required this.labelText,
  });

  final String? labelText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        maxLines: 4,
        cursorColor: Color(0xffD8D8D8),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.circular(
              32,
            ),
          ),
          hintText: labelText,
          hintStyle: TextStyles.font12regularGray,
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
