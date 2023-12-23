import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    required this.labelText,
    this.IconWidget,
    this.controller,
  });

  String? labelText;
  Widget? IconWidget;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffD8D8D8)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 55,
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconWidget,
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              width: 1,
              height: 55,
              decoration: BoxDecoration(
                color: Color(0xffD8D8D8),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                cursorColor: Color(0xffD8D8D8),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  labelText: labelText,
                  labelStyle: TextStyles.font12regularGray,
                  filled: true,
                  fillColor: Colors.white,
                  // prefixIcon: IconWidget,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
