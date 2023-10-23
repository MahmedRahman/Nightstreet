import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/order_card_view.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_dimens.dart';

import '../controllers/orders_list_controller.dart';

class OrdersListView extends GetView<OrdersListController> {
  const OrdersListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: 'سجـل الطلبــات',
      ),
      body: controller.obx(
        (orders) => ListView.builder(
          padding: AppDimension.appPadding,
          itemCount: (orders as List).length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: OrderCardView(
                orderNo: order['orderNo'],
                orderDate: order['orderDate'],
                status: order['status'],
                productCount: order['productCount'],
                price: order['price'],
                onTap: () {
                  if (order['status'] == 'تم التوصيل') {
                    Get.toNamed(Routes.ORDER_DETAILS_DELIVERED);
                    return;
                  }

                  if (order['status'] == "قيد التوصيل") {
                    Get.toNamed(Routes.ORDER_DETAILS_UNDERWAY);
                    return;
                  }

                  Get.toNamed(Routes.ORDER_DETAILS_CANCELLED);
                  return;
                },
              ),
            );
          },
        ),
        onEmpty: AppPageEmpty.ordersList(),
      ),
    );
  }
}
