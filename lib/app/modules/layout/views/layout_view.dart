import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/account_menu/views/account_menu_view.dart';
import 'package:krzv2/app/modules/home_page/views/home_page_view.dart';
import 'package:krzv2/app/modules/home_page_products/views/home_page_products_view.dart';
import 'package:krzv2/app/modules/home_page_services/views/home_page_services_view.dart';
import 'package:krzv2/app/modules/offer_list/views/offer_list_view.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';

import '../controllers/layout_controller.dart';

class LayoutView extends GetView<LayoutController> {
  final bottomNavigationBarController = Get.put(MyBottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Obx(
          () {
            {
              switch (bottomNavigationBarController.currentIndex.value) {
                case 0:
                  return HomePageView();
                case 1:
                  return HomePageServicesView();
                case 2:
                  return HomePageProductsView();
                case 3:
                  return OfferListView();
                default:
                  return AccountMenuView();
              }
            }
          },
        ),
      ),
    );
  }
}
