import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MealNameAndRate extends GetView {
  const MealNameAndRate({
    super.key,
    required this.name,
    required this.rate,
  });

  final String name;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyles.font16regularBlack2,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            color: Color(0x1affc554),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("images/svg/start.svg"),
              SizedBox(width: 5),
              Text(
                rate,
                style: TextStyles.font12regularBlack,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
