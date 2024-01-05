import 'package:app_night_street/app/routes/app_pages.dart';
import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/custom_back_button.dart';
import 'package:app_night_street/core/component/order_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_orders_controller.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: myOrderAppBar(),
      child: TabBarView(
        controller: controller.tabController,
        children: [
          ListView(
            padding: AppDimension.appPadding.copyWith(top: 25),
            children: [
              OrderItem(
                orderNo: '#001158',
                productNumber: '١٥ منتج',
                orderDate: '2022-08-22 12:44:16',
                orderPrice: "1200",
                onTap: () => Get.toNamed(Routes.ORDER_DETAILS),
              ),
            ],
          ),
          ListView(
            padding: AppDimension.appPadding.copyWith(top: 25),
            children: [
              OrderItem(
                orderNo: '#001158',
                productNumber: '١٥ منتج',
                orderDate: '2022-08-22 12:44:16',
                orderPrice: "1200",
                onTap: () => Get.toNamed(Routes.ORDER_DETAILS),
              ),
            ],
          ),
          ListView(
            padding: AppDimension.appPadding.copyWith(top: 25),
            children: [
              OrderItem(
                orderNo: '#001158',
                productNumber: '١٥ منتج',
                orderDate: '2022-08-22 12:44:16',
                orderPrice: "1200",
                onTap: () => Get.toNamed(Routes.ORDER_DETAILS),
              ),
            ],
          ),
          ListView(
            padding: AppDimension.appPadding.copyWith(top: 25),
            children: [
              OrderItem(
                orderNo: '#001158',
                productNumber: '١٥ منتج',
                orderDate: '2022-08-22 12:44:16',
                orderPrice: "1200",
                onTap: () => Get.toNamed(Routes.ORDER_DETAILS),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar myOrderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 4,
      shadowColor: Color(0x1a000000),
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Row(
        children: [
          CustomBackButton(
            backGroundColor: Color(0x0f6c727f),
          ),
          const SizedBox(width: 10),
          Text(
            'طلباتي',
            style: TextStyle(
              fontSize: 18.0,
              color: AppColor.KBlackColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
      bottom: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: AppColor.KOrangeColor,
        unselectedLabelStyle: TextStyle(
          fontFamily: "Montserrat",
          fontSize: 13,
          color: AppColor.KBlackColor,
          fontWeight: FontWeight.w600,
        ),
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 13,
          color: const Color(0xfff26404),
          fontWeight: FontWeight.w600,
        ),
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        indicatorWeight: 5,
        controller: controller.tabController,
        labelPadding: EdgeInsets.only(bottom: 10),
        tabs: [
          Text('الجديدة'),
          Text('الاساسية'),
          Text('مكتملة'),
          Text('مرفوضة'),
        ],
      ),
    );
  }
}
