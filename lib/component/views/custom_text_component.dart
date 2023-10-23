import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.title, {
    super.key,
    required this.color,
  });

  const CustomText.red(
    this.title, {
    super.key,
  }) : color = Colors.red;

  const CustomText.underLine(
    this.title, {
    super.key,
  }) : color = Colors.black;

  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
