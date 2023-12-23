import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/cashed_network_image_view.dart';
import 'package:app_night_street/core/component/custom_app_bar.dart';
import 'package:app_night_street/core/component/custom_tap_bar.dart';
import 'package:app_night_street/core/component/meal_counter.dart';
import 'package:app_night_street/core/component/meal_delivery_time.dart';
import 'package:app_night_street/core/component/meal_details_fav_icon.dart';
import 'package:app_night_street/core/component/meal_item.dart';
import 'package:app_night_street/core/component/meal_name_and_rate.dart';
import 'package:app_night_street/core/component/meal_size.dart';
import 'package:app_night_street/core/component/size_selector.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/meal_details_controller.dart';

class MealDetailsView extends GetView<MealDetailsController> {
  const MealDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          mealImage(),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: context.width,
                margin: EdgeInsets.only(
                  top: Get.height * .4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(37),
                    topRight: Radius.circular(37),
                  ),
                ),
                child: CustomTapBar(
                  label1: 'التفاصيل',
                  label2: 'التقييمات',
                  widget1: SingleChildScrollView(
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
                      ],
                    ),
                  ),
                  widget2: SingleChildScrollView(
                    child: Column(),
                  ),
                ),
              ),
              mealDetailsFavIcon(),
            ],
          ),
        ],
      ),
    );
  }

  Container mealImage() {
    return Container(
      height: Get.height / 2.2,
      child: CashedNetworkImageView(
        imageUrl:
            "https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?q=80&w=2615&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ),
    );
  }
}
