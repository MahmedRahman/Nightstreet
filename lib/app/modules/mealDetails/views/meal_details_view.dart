import 'package:app_night_street/core/component/cashed_network_image_view.dart';
import 'package:app_night_street/core/component/custom_tap_bar.dart';
import 'package:app_night_street/core/component/meal_details_fav_icon.dart';
import 'package:app_night_street/core/component/meal_info.dart';
import 'package:app_night_street/core/component/meal_reviews.dart';
import 'package:app_night_street/core/component/orange_bottom.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
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
                  widget2: MealReviews(),
                ),
              ),
              mealDetailsFavIcon(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: addToCartBtnAndPrice(
        price: '2000',
        onAddToCartTapped: () {},
      ),
    );
  }

  Container addToCartBtnAndPrice({
    required String price,
    required Function onAddToCartTapped,
  }) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1a000000),
            offset: Offset(0, 10),
            blurRadius: 60,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: OrangeBtn(
                title: 'اضف الي العربة',
                iconPath: "images/svg/white_cart_icon.svg",
                onTap: () => onAddToCartTapped(),
              ),
            ),
          ),
          Row(
            children: [
              SvgPicture.asset("images/svg/price_icon.svg"),
              const SizedBox(width: 6),
              Text(
                '$price جنيه',
                style: TextStyles.font16regularBlack2,
              ),
            ],
          ),
          const SizedBox(width: 20),
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
