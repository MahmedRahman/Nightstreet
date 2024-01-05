import 'package:app_night_street/app/routes/app_pages.dart';
import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/cashed_network_image_view.dart';
import 'package:app_night_street/core/component/menu_main_information.dart';
import 'package:app_night_street/core/component/menu_notification_setting.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

class MenuView extends GetView {
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: _buildAppBar(),
      child: ListView(
        padding: AppDimension.appPadding.copyWith(top: 40),
        children: [
          _horizontalIcons(),
          const SizedBox(height: 35),
          MenuNotificationSetting(
            onNotificationChanged: (newValue) {},
          ),
          const SizedBox(height: 35),
          MainInformation(
            onAboutTapped: () => Get.toNamed(Routes.ABOUT),
            onTermsTapped: () => Get.toNamed(Routes.TERMS),
            onContactUsTapped: () => Get.toNamed(Routes.CONTACT_US),
            onShareTapped: () => Get.toNamed(Routes.SHARE_APP),
          ),
          const SizedBox(height: 50),
          logoutButton(onTap: () {})
        ],
      ),
    );
  }

  Widget logoutButton({required Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("images/svg/logout_icon.svg"),
          const SizedBox(width: 15),
          Text(
            'تسجيل خروج',
            style: TextStyles.font14MediumRed,
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: Colors.red,
          ),
          child: CashedNetworkImageView(
            imageUrl:
                "https://st4.depositphotos.com/1007566/26875/v/1600/depositphotos_268757182-stock-illustration-cute-grandfather-avatar-character.jpg",
          ),
        ),
      ),
      actions: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                overlayColor: MaterialStatePropertyAll(Colors.white),
                onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset("images/svg/Notification.svg"),
                ),
              ),
            ),
            Container(
              width: 18.21,
              height: 18.21,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.KRedColor,
              ),
              child: Center(
                child: Text(
                  '2',
                  style: TextStyles.font12RegularWhite,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }

  Widget _horizontalIcons() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(11.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0x08000000),
            offset: Offset(0, 5),
            blurRadius: 60,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconButton(
            title: "طلباتي",
            icon: "images/svg/my_orders.svg",
            onTap: () => Get.toNamed(Routes.MY_ORDERS),
          ),
          _buildIconButton(
            title: "العناوين",
            icon: "images/svg/address_icon.svg",
            onTap: () => Get.toNamed(Routes.ADDRESSES),
          ),
          _buildIconButton(
            title: "الإعدادات",
            icon: "images/svg/setting_icon.svg",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required String title,
    required String icon,
    required Function()? onTap,
  }) {
    return InkWell(
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyles.font14mediumBlack,
          )
        ],
      ),
    );
  }
}
