import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class MyBottomNavigationController extends GetxController {
  var currentIndex = 0.obs;
  void changePage(int index) {
    if (Get.routing.current != Routes.LAYOUT)
      Get.until((route) => route.settings.name == '/layout');

    currentIndex.value = index;
  }
}

TextStyle selectedLabelStyle = TextStyle(
  fontSize: 14.0,
  color: AppColors.mainColor,
);

class BottomNavigationBarView extends GetView<MyBottomNavigationController> {
  BottomNavigationBarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              offset: Offset(0, -3.0),
              blurRadius: 7.0,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: _buildNavigationBarItems(),
          backgroundColor: Colors.white,
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: AppColors.greyColor,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: selectedLabelStyle,
          unselectedLabelStyle: selectedLabelStyle.copyWith(
            color: AppColors.greyColor,
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavigationBarItems() {
    return [
      _buildNavigationBarItem(
        AppSvgAssets.homeIcon,
        controller.currentIndex.value == 0,
        "الرئيسية",
      ),
      _buildNavigationBarItem(
        AppSvgAssets.servicesIcon,
        controller.currentIndex.value == 1,
        "العيادات",
      ),
      _buildNavigationBarItem(
        AppSvgAssets.productsIcon,
        controller.currentIndex.value == 2,
        "المتاجر",
      ),
      _buildNavigationBarItem(
        AppSvgAssets.offersIcon,
        controller.currentIndex.value == 3,
        "العروض",
      ),
      _buildNavigationBarItem(
        AppSvgAssets.accountIcon,
        controller.currentIndex.value == 4,
        "الحساب",
      ),
    ];
  }

  BottomNavigationBarItem _buildNavigationBarItem(
      String svgAsset, bool isSelected, String label) {
    return BottomNavigationBarItem(
      icon: _buildSvgIcon(svgAsset, isSelected),
      label: label,
      tooltip: label,
    );
  }

  Widget _buildSvgIcon(String svgAsset, bool isSelected) {
    return SvgPicture.asset(
      svgAsset,
      color: isSelected || svgAsset == AppSvgAssets.offersIcon
          ? AppColors.mainColor
          : AppColors.greyColor,
    );
  }
}
