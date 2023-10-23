import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';

class CustomTabBarView extends GetView {
  final List<String> tabTitles;
  final List<Widget> tabContent;

  CustomTabBarView({
    required this.tabTitles,
    required this.tabContent,
  });

  final _currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: tabTitles.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ButtonsTabBar(
              contentPadding: const EdgeInsets.all(10),
              splashColor: Colors.transparent,
              backgroundColor: AppColors.mainColor,
              unselectedBackgroundColor: AppColors.greyColor4,
              unselectedLabelStyle: TextStyle(
                fontSize: 14.0,
                color: AppColors.blackColor,
                letterSpacing: 0.14,
                height: 0.86,
              ),
              borderColor: Colors.transparent,
              unselectedBorderColor: AppColors.borderColor2,
              borderWidth: 1,
              radius: 8,
              labelStyle: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                letterSpacing: 0.14,
                height: 0.86,
              ),
              tabs: tabTitles.map((title) {
                return Tab(text: title);
              }).toList(),
              onTap: (index) {
                _currentIndex.value = index;
              },
            ),
            Expanded(
              child: tabContent[_currentIndex.value],
            ),
          ],
        ),
      ),
    );
  }
}
