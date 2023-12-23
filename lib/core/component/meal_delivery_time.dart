import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MealDeliveryTime extends GetView {
  const MealDeliveryTime({
    super.key,
    required this.time,
  });

  final String time;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "images/svg/delivery-bike.svg",
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          time,
          style: TextStyles.font12regularBlack,
        ),
      ],
    );
  }
}
