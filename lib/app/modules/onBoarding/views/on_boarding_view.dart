import 'package:app_night_street/app/routes/app_pages.dart';
import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/component/custom_base_scaffold.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
          Image.asset("images/png/onBording.png"),
          SizedBox(
            height: 121,
          ),
          Column(
            children: [
              Text(
                'متعدد الأقسام',
                style: TextStyles.font17boldBlack,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 21,
              ),
              Text(
                'نقدم لك تجربة مستخدم لك لعائلتك بأختيارك تطبيق  - اسم التطبيق',
                style: TextStyles.font13regularGray.copyWith(
                  height: 2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 47,
          ),
          CircleAvatar(
            backgroundColor: AppColor.KOrangeColor,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
          SizedBox(
            height: 47,
          ),
          CustomButton.textButton(
            textStyleColor: Colors.black,
            title: "تخطي",
            onPressed: () {
              Get.toNamed(
                Routes.MAP_PERMISSION,
              );
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}
