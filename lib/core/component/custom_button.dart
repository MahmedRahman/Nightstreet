import 'package:app_night_street/core/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton.fill({
    this.backgroundColor = Colors.red,
    this.borderSideColor = Colors.red,
    this.textStyleColor = Colors.white,
    this.title = "دخول",
  });

  CustomButton.outLine({
    this.backgroundColor = Colors.transparent,
    this.borderSideColor = Colors.red,
    this.textStyleColor = Colors.red,
    this.title = "دخول",
  });

  CustomButton.textButton({
    this.backgroundColor = Colors.transparent,
    this.borderSideColor = Colors.transparent,
    this.textStyleColor = Colors.red,
    this.title = "دخول",
  });

 

  Color backgroundColor;
  Color borderSideColor;
  Color textStyleColor;
  String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        autofocus: false,
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
          '${title}',
          style: TextStyle(
            fontSize: 14.0,
            height: 1,
            color: textStyleColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
