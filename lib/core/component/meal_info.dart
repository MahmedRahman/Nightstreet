import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/meal_counter.dart';
import 'package:app_night_street/core/component/meal_delivery_time.dart';
import 'package:app_night_street/core/component/meal_name_and_rate.dart';
import 'package:app_night_street/core/component/size_selector.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealInfo extends StatelessWidget {
  const MealInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppDimension.appPadding.copyWith(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MealNameAndRate(
            name: 'عرض وجبة الصحاب',
            rate: '4.9',
          ),
          const SizedBox(height: 14),
          MealDeliveryTime(
            time: '25 - 20 دقيقة',
          ),
          const SizedBox(height: 21),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '340 جنيه',
                style: TextStyles.font12regularBlack,
                textAlign: TextAlign.right,
              ),
              MealCounter(
                onCounterChanged: (int counter) {},
              ),
            ],
          ),
          const SizedBox(height: 21),
          Container(
            width: Get.width,
            height: 1,
            color: AppColor.KdividerColor,
          ),
          const SizedBox(height: 16),
          Text(
            'إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع.',
            style: TextStyles.font12regularBlack,
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 16),
          Container(
            width: Get.width,
            height: 1,
            color: AppColor.KdividerColor,
          ),
          const SizedBox(height: 21),
          SizeSelector(
            onSizedChanged: (String) {},
          ),
          const SizedBox(height: 10),
          Container(
            width: Get.width,
            height: 1,
            color: AppColor.KdividerColor,
          ),
          const SizedBox(height: 21),
        ],
      ),
    );
  }
}
