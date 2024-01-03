import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/custom_app_bar.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/component/empty_app_bar.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/share_app_controller.dart';

class ShareAppView extends GetView<ShareAppController> {
  const ShareAppView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: CustomAppBar(
        titleText: 'شارك التطبيق مع صديق و اكسب',
      ),
      child: Container(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("images/svg/share_app_icon.svg"),
            Text(
              'لما تشارك مع أصحابك \n أنت هتكسب وهم هيكسبوا',
              style: TextStyles.font16regularBlack2.copyWith(
                height: 2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppDimension.appPadding.copyWith(
          bottom: 40,
        ),
        child: CustomButton.fill(
          onPressed: () {},
          title: "شارك التطبيق دلوقتي",
          borderRadius: 32,
        ),
      ),
    );
  }
}
