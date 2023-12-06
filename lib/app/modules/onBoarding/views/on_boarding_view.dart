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
        children: [
          Image.asset("images/png/onBording.png"),
          Text(
            'متعدد الأقسام',
            style: TextStyles.font17boldBlack,
            textAlign: TextAlign.center,
          ),
          Text(
            'نقدم لك تجربة مستخدم لك لعائلتك بأختيارك تطبيق  - اسم التطبيق',
            style: TextStyles.font13regularGray,
            textAlign: TextAlign.center,
          ),
          CustomButton.textButton(
            textStyleColor: Colors.black,
            title: "تخطي",
          )
        ],
      ),
    );
  }
}
