import 'package:app_night_street/app/routes/app_pages.dart';
import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/cart_item_builder.dart';
import 'package:app_night_street/core/component/cart_summary_builder.dart';
import 'package:app_night_street/core/component/custom_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: CustomAppBar(
        titleText: "سلة الشراء",
        withBackButton: false,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              padding: AppDimension.appPadding,
              itemCount: 3,
              itemBuilder: (context, index) {
                return CartItemBuilder.dummy();
              },
            ),
          ),
          CartSummary.dummy(
            onCompleteOrderTapped: () => Get.toNamed(Routes.ADDRESSES),
          )
        ],
      ),
    );
  }
}
