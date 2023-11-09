import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/component/views/icon_button_component.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class ShoppingCartIconView extends GetView {
  const ShoppingCartIconView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShoppingCartController>(
      builder: (controller) {
        return CustomIconButton(
          onTap: () => Get.toNamed(Routes.SHOPPINT_CART),
          iconPath: AppSvgAssets.cartIcon,
          count: controller.productCount,
        );
      },
    );
  }
}
