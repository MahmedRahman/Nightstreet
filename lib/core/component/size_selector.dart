import 'package:app_night_street/core/component/meal_size.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SizeSelector extends GetView {
  const SizeSelector({
    super.key,
    required this.onSizedChanged,
  });

  final Function(String) onSizedChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اختر الحجم',
          style: TextStyles.font14mediumBlack,
          textAlign: TextAlign.right,
          softWrap: false,
        ),
        const SizedBox(height: 14),
        MealSize(
          onSizedChanged: onSizedChanged,
        ),
      ],
    );
  }
}
