import 'package:app_night_street/core/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton.fill({
    this.backgroundColor = Colors.red,
    this.borderSideColor = Colors.red,
    this.textStyleColor = Colors.white,
  });

  CustomButton.outLine({
    this.backgroundColor = Colors.transparent,
    this.borderSideColor = Colors.red,
    this.textStyleColor = Colors.red,
  });

  CustomButton.textButton({
    this.backgroundColor = Colors.transparent,
    this.borderSideColor = Colors.transparent,
    this.textStyleColor = Colors.red,
  });
  Color backgroundColor;
  Color borderSideColor;
  Color textStyleColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(
              color: borderSideColor,
            ),
          ),
        ),
        child: Text(
          'دخول',
          style: TextStyle(
            fontSize: 14.0,
            height: 1.5,
            color: textStyleColor,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    // return InkWell(
    //   child: Container(
    //     height: 64,
    //     width: double.infinity,
    //     decoration: BoxDecoration(
    //       color: AppColor.KOrangeColor,
    //       borderRadius: BorderRadius.circular(16),
    //     ),
    //     child: Center(
    //       child: Text(
    //         'دخول',
    //         style: TextStyle(
    //           fontSize: 14.0,
    //           height: 1.5,
    //           color: const Color(0xFFF6F6F6),
    //           fontWeight: FontWeight.w600,
    //         ),
    //         textAlign: TextAlign.center,
    //       ),
    //     ),
    //   ),
    // );
  }
}
