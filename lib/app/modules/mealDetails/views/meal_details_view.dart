import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/cashed_network_image_view.dart';
import 'package:app_night_street/core/component/custom_app_bar.dart';
import 'package:app_night_street/core/component/custom_tap_bar.dart';
import 'package:app_night_street/core/component/meal_counter.dart';
import 'package:app_night_street/core/component/meal_delivery_time.dart';
import 'package:app_night_street/core/component/meal_details_fav_icon.dart';
import 'package:app_night_street/core/component/meal_info.dart';
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
                  widget1: MealInfo(),
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
