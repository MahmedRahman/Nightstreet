import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/favorite/controllers/clinic_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/app/modules/favorite/controllers/product_favorite_controller.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shoppint_cart_controller.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/app_bar.dart';
import 'package:krzv2/component/views/icon_button_component.dart';
import 'package:krzv2/component/views/notification_icon_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/shopping_cart_icon_view.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/account_menu_controller.dart';

class AccountMenuView extends GetView<AccountMenuController> {
  AccountMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(builder: (authController) {
      return BaseScaffold(
        appBar: TitleSubtitleAppBar(
          titleText: 'مرحباً بك',
          subTitle: authController.userData?.name ?? '',
          actions: [
            if (authController.isLoggedIn || authController.isGuestUser)
              ShoppingCartIconView(),
            if (authController.isLoggedIn) NotificationIconView(),
            AppSpacers.width20,
          ],
        ),
        body: ListView(
          padding: AppDimension.appPadding,
          children: [
            AppSpacers.height10,
            if (authController.isLoggedIn)
              GetBuilder<AuthenticationController>(
                builder: (controller) {
                  return _walletListTile(
                    walletBalance:
                        '${controller.userData?.walletBalance ?? ''}',
                    onWalletTapped: () => Get.toNamed(Routes.walletPage),
                  );
                },
              ),
            AppSpacers.height12,
            if (authController.isLoggedIn)
              DecoratedContainer(
                child: Column(
                  children: [
                    _CustomListTile(
                      title: 'البيانات الشخصية',
                      iconPath: AppSvgAssets.profileIcon,
                      onTap: () => Get.toNamed(Routes.updateProfile),
                    ),
                    _CustomListTile(
                      title: "المفضلة",
                      iconPath: AppSvgAssets.favoriteIcon,
                      onTap: () {
                        Get.toNamed(Routes.FAVORITE);
                      },
                    ),
                    _CustomListTile(
                      title: "طلباتي",
                      iconPath: AppSvgAssets.myOrdersIcon,
                      onTap: () => Get.toNamed(Routes.ORDERS_LIST),
                    ),
                    _CustomListTile(
                      title: "مواعيدي",
                      iconPath: AppSvgAssets.myApointmentIcon,
                      onTap: () => Get.toNamed(Routes.APPOINTMENT_MANGMENT),
                    ),
                    _CustomListTile(
                      title: "بطاقات الهدايا",
                      iconPath: AppSvgAssets.giftIcon,
                      onTap: () => Get.toNamed(Routes.GIFT_CARDS),
                    ),
                    _CustomListTile(
                      title: "عناويني",
                      iconPath: AppSvgAssets.policiesIcon,
                      onTap: () => Get.toNamed(Routes.DELIVERY_ADDRESSES),
                    ),
                    _CustomListTile(
                      title: "تواصل معنا",
                      iconPath: AppSvgAssets.contactUsIcon,
                      onTap: () => Get.toNamed(Routes.COMPLAINT_MANAGER),
                    ),
                  ],
                ),
              ),
            AppSpacers.height12,
            DecoratedContainer(
              child: Column(
                children: [
                  _CustomListTile(
                    title: "عن التطبيق",
                    iconPath: AppSvgAssets.aboutIcon,
                    onTap: () => Get.toNamed(Routes.aboutUsPage),
                  ),
                  _CustomListTile(
                    title: "السياسات",
                    iconPath: AppSvgAssets.policiesIcon,
                    onTap: () => Get.toNamed(Routes.termsPage),
                  ),
                  _CustomListTile(
                    title: "الأسئلة الشائعة",
                    iconPath: AppSvgAssets.faqIcon,
                    onTap: () => Get.toNamed(Routes.faqPage),
                  ),
                ],
              ),
            ),
            AppSpacers.height12,
            if (authController.isLoggedIn)
              DecoratedContainer(
                child: _CustomListTile(
                  title: 'تسجيل خروج',
                  iconPath: AppSvgAssets.logOutIcon,
                  onTap: () => authController.logout(
                    onSuccess: () {
                      Get.find<ProductFavoriteController>()
                          .productFavoriteIds
                          .value
                          ?.clear();
                      Get.find<OfferFavoriteController>()
                          .offerFavoriteIds
                          .value
                          ?.clear();
                      Get.find<CliniFavoriteController>()
                          .clinicsFavoriteIds
                          .value
                          ?.clear();
                    },
                  ),
                ),
              ),
            AppSpacers.height12,
            if (authController.isLoggedIn == false)
              DecoratedContainer(
                child: _loginButton(
                  title: 'تسجيل دخول',
                  iconPath: AppSvgAssets.loginIcon,
                  onTap: () => Get.toNamed(
                    Routes.REGISTER,
                    arguments: '01115922240',
                  ),
                ),
              ),
            AppSpacers.height12,
          ],
        ),
      );
    });
  }

  Widget _walletListTile({
    required String walletBalance,
    required Function() onWalletTapped,
  }) {
    return DecoratedContainer(
      child: ListTile(
        onTap: onWalletTapped,
        leading: SvgPicture.asset(AppSvgAssets.walletIcon),
        title: Text(
          'المحفظة',
          style: TextStyle(
            fontSize: 16.0,
            color: AppColors.blackColor,
            letterSpacing: 0.48,
          ),
          textAlign: TextAlign.right,
        ),
        trailing: Container(
          width: 100.0,
          height: 30.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: AppColors.borderColor2,
          ),
          child: Center(
            child: Text(
              '$walletBalance ر.س',
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.mainColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ),
    );
  }

  ListTile _CustomListTile({
    required String title,
    required String iconPath,
    required Function() onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(iconPath),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: AppColors.blackColor,
          letterSpacing: 0.48,
        ),
        textAlign: TextAlign.right,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppColors.blackColor,
        size: 15,
      ),
    );
  }

  ListTile _loginButton({
    required String title,
    required String iconPath,
    required Function() onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SvgPicture.asset(
            iconPath,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: AppColors.blackColor,
          letterSpacing: 0.48,
        ),
        textAlign: TextAlign.right,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppColors.blackColor,
        size: 15,
      ),
    );
  }
}
