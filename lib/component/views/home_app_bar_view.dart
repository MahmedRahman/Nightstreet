import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/notification_icon_view.dart';
import 'package:krzv2/component/views/shopping_cart_icon_view.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class HomeAppBarView extends GetView implements PreferredSizeWidget {
  final String? title;
  final String? subTitle;

  HomeAppBarView({
    super.key,
    this.title,
    this.subTitle,
  });
  final authController = Get.find<AuthenticationController>();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? 'استكشــف',
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.mainColor,
              letterSpacing: 0.42,
              height: 0.86,
            ),
            textAlign: TextAlign.right,
          ),
          AppSpacers.height10,
          Text(
            subTitle ?? 'أقوى العروض',
            style: TextStyle(
              fontSize: 16.0,
              color: AppColors.blackColor,
              letterSpacing: 0.64,
              fontWeight: FontWeight.w500,
              height: 0.75,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
      actions: [
        if (authController.isLoggedIn || authController.isGuestUser)
          ShoppingCartIconView(),
        if (authController.isLoggedIn) NotificationIconView(),
        AppSpacers.width20,
      ],
      // actions: (authController.isLoggedIn || authController.isGuestUser)
      //     ? [
      //         ShoppingCartIconView(),
      //         NotificationIconView(),
      //         AppSpacers.width20,
      //       ]
      //     : [],
    );
  }
}
