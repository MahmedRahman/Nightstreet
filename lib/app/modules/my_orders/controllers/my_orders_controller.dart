import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrdersController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  RxInt _selectedIndex = 0.obs;
  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);

    tabController!.addListener(() {
      _selectedIndex.value = tabController!.index;
    });
    super.onInit();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }
}
