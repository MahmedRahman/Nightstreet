import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/component/empty_app_bar.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../core/component/base_body.dart';
import '../controllers/order_success_controller.dart';

class OrderSuccessView extends GetView<OrderSuccessController> {
  const OrderSuccessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: EmptyAppBar(),
      child: Container(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("images/svg/order_success.svg"),
            Text(
              'تم ارسال طلبك بنجاح',
              style: TextStyles.font16regularBlack2,
            ),
            const SizedBox(height: 22),
            Text(
              'بإمكانك الان متابعة حالة الطلب ، من خلال رقم الطلب \n #00189',
              style: TextStyles.font12regularGray.copyWith(
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppDimension.appPadding.copyWith(
          bottom: 40,
        ),
        child: Container(
          height: 150,
          child: Column(
            children: [
              CustomButton.fill(
                onPressed: () {},
                title: "طلباتي",
                borderRadius: 32,
              ),
              const SizedBox(height: 16),
              CustomButton.outLine(
                onPressed: () {},
                title: "الرئيسية",
                borderRadius: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
