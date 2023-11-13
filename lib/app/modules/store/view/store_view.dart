import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/cards/product_card_view.dart';
import 'package:krzv2/component/views/cards/service_card_view.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/notification_icon_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/shopping_cart_icon_view.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_spacers.dart';

class StorePage extends GetView {
  final authController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: "متجر",
        actions: [
          if (authController.isLoggedIn || authController.isGuestUser) ShoppingCartIconView(),
          if (authController.isLoggedIn) NotificationIconView(),
          AppSpacers.width20,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ServiceCardView.dummy().paddingOnly(bottom: 10),
            Row(
              children: [
                Text("المتاجر"),
                Spacer(),
                //Text("عرض الكل"),
              ],
            ),
            Expanded(
              child: productsList(products: [
                "",
                "",
                "",
                "",
                "",
                "",
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

final double itemHeight = (Get.height - kToolbarHeight - 24) / 1;
final double itemWidth = Get.width / 2;

GridView productsList({
  required List products,
}) {
  return GridView.builder(
    itemCount: products.length,
    padding: EdgeInsets.only(top: 10),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight) / .35,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemBuilder: (_, index) {
      //final product = products?.elementAt(index);
      return ProductCardView.dummy();
    },
  );
}
