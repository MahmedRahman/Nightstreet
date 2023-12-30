import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/custom_app_bar.dart';
import 'package:app_night_street/core/component/radio_btn_component.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/complete_order_controller.dart';

class CompleteOrderView extends GetView<CompleteOrderController> {
  const CompleteOrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: CustomAppBar(titleText: "إتمــام الطلب"),
      child: ListView(
        padding: AppDimension.appPadding.copyWith(
          top: 37,
        ),
        children: [
          Text(
            'عناوين التوصيل',
            style: TextStyles.font14mediumBlack,
          ),
          const SizedBox(height: 17),
          selectedWidget()
        ],
      ),
    );
  }

  Container selectedWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 17,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          RadioBtn(
            isSelected: true,
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'المنزل',
                style: TextStyles.font12regularGray2,
              ),
              const SizedBox(height: 3),
              Container(
                constraints: BoxConstraints(
                  maxWidth: Get.width * .6,
                ),
                child: Text(
                  'منوف شارع مجلس المدينة ، عمارة ٤ب',
                  style: TextStyles.font14mediumBlack,
                  maxLines: 1,
                ),
              )
            ],
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
        ],
      ),
    );
  }
}
