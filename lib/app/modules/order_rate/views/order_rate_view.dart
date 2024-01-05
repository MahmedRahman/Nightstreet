import 'package:app_night_street/app/routes/app_pages.dart';
import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/cashed_network_image_view.dart';
import 'package:app_night_street/core/component/custom_app_bar.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/order_rate_controller.dart';

class OrderRateView extends GetView<OrderRateController> {
  RxDouble rate = 0.0.obs;

  String getImageBasedOnRate(double rate) {
    print('rate ${rate == 5.0}');

    if (rate.toInt() == 5) {
      return "images/svg/lovely_face.svg";
    }
    if (rate.toInt() > 2) {
      return "images/svg/happy_face.svg";
    }

    return "images/svg/sad_face.svg";
  }

  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: CustomAppBar(titleText: 'تقييم الطعام'),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemBuilder: (_, index) => mealItem(
                image:
                    "https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?q=80&w=2615&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                name: "عرض وجبة الصحاب",
                price: "340 جنيه",
              ),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
            ),
          ),
          SizedBox(height: 70),
          rateForm(
            onRatingUpdate: (val) {
              rate.value = val;
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppDimension.appPadding.copyWith(
          bottom: 40,
        ),
        child: CustomButton.outLine(
          onPressed: () => Get.offAllNamed(Routes.HOME_PAGE),
          title: "حفظ التقييم",
          borderRadius: 32,
        ),
      ),
    );
  }

  Obx rateForm({
    required Function(double) onRatingUpdate,
  }) {
    return Obx(
      () {
        return Column(
          children: [
            SvgPicture.asset(getImageBasedOnRate(rate.value)),
            SizedBox(height: 40),
            Container(
              height: 75,
              width: 275,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(21.0),
              ),
              child: Center(
                child: RatingBar(
                  initialRating: 2,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  glowColor: AppColor.KOrangeColor,
                  itemSize: 40,
                  ratingWidget: RatingWidget(
                    full: SvgPicture.asset("images/svg/full_rate.svg"),
                    half: SizedBox(),
                    empty: SvgPicture.asset("images/svg/empty_rate.svg"),
                  ),
                  onRatingUpdate: onRatingUpdate,
                  itemPadding: EdgeInsets.only(left: 3),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Container mealItem({
    required String image,
    required String name,
    required String price,
  }) {
    return Container(
      padding: EdgeInsets.all(13),
      margin: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          CashedNetworkImageView(
            imageUrl: image,
            height: 89,
            width: 74,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: Get.width * .5),
                child: Text(
                  name,
                  style: TextStyles.font14mediumBlack,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                ),
              ),
              Text(
                price,
                style: TextStyles.font14mediumBlack,
                textAlign: TextAlign.right,
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
