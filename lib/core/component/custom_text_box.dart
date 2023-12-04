import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CustomTextBox extends StatelessWidget {
  CustomTextBox({
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
        border: Border.all(),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.r_mobiledata),
          ),
          Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(16),
                  //   borderSide: BorderSide(
                  //     width: 1,
                  //     style: BorderStyle.solid,
                  //     color: Color(0xffD8D8D8),
                  //   ),
                  // ),
                  labelText: labelText,
                  labelStyle: TextStyle(
                    fontSize: 11.0,
                    color: const Color(0xFFABABB7),
                    fontWeight: FontWeight.w300,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: IconWidget,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
