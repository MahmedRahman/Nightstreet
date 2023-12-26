import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton.fill({
    this.backgroundColor = Colors.red,
    this.borderSideColor = Colors.red,
    this.textStyleColor = Colors.white,
    this.title = "دخول",
    this.borderRadius = 18.0,
    this.onPressed,
  });

  CustomButton.outLine({
    this.backgroundColor = Colors.transparent,
    this.borderSideColor = Colors.red,
    this.textStyleColor = Colors.red,
    this.title = "دخول",
    this.borderRadius = 18.0,
    this.onPressed,
  });

  CustomButton.textButton({
    this.backgroundColor = Colors.transparent,
    this.borderSideColor = Colors.transparent,
    this.textStyleColor = Colors.red,
    this.title = "دخول",
    this.borderRadius = 18.0,
    this.onPressed,
  });

  Color backgroundColor;
  Color borderSideColor;
  Color textStyleColor;
  String title;
  void Function()? onPressed;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        autofocus: false,
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(color: borderSideColor),
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
