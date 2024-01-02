import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/custom_app_bar.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/component/order_copuon_field.dart';
import 'package:app_night_street/core/component/order_notes_field.dart';
import 'package:app_night_street/core/component/order_selected_address.dart';
import 'package:app_night_street/core/component/order_summary.dart';
import 'package:app_night_street/core/component/payment_methods.dart';
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
          SelectedAddress(
            title: 'المنزل',
            description: 'منوف شارع مجلس المدينة ، عمارة ٤ب',
          ),
          const SizedBox(height: 33),
          PaymentMethods(
            onChanged: (String paymentMethod) {},
          ),
          const SizedBox(height: 33),
          OrderNotesField(
            onChanged: (String value) {},
          ),
          const SizedBox(height: 33),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CopounField(
                  onSubmitCopoun: (String) {},
                ),
                const SizedBox(height: 27),
                Text(
                  "ملخص الطلب",
                  style: TextStyles.font12MediumBlack,
                ),
                const SizedBox(height: 27),
                OrderSummary.dummy(),
              ],
            ),
          ),
          const SizedBox(height: 33),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppDimension.appPadding.copyWith(
          bottom: 40,
        ),
        child: CustomButton.fill(
          onPressed: () {},
          title: "اتمام الطلب",
          borderRadius: 32,
        ),
      ),
    );
  }
}
