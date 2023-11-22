import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/order_card_view.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/pages/app_page_loading_more.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/order_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_dimens.dart';

import '../controllers/orders_list_controller.dart';

class OrdersListView extends GetView<OrdersListController> {
  const OrdersListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      onRefresh: () async => controller.refreshList(),
      appBar: CustomAppBar(
        titleText: 'سجـل الطلبــات',
      ),
      body: controller.obx(
        (List<OrderModel>? orders) => ListView.builder(
          padding: AppDimension.appPadding,
          itemCount: (orders as List).length,
          controller: controller.scroll,
          itemBuilder: (context, index) {
            final order = orders![index];

            if (index == orders.length - 1) {
              return AppPageLoadingMore(
                display: controller.status.isLoadingMore,
              );
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: OrderCardView(
                orderNo: order.id.toString(),
                orderDate: order.createdAt,
                status: order.status,
                statusNum: order.statusNum,
                price: order.total.toString(),
                onTap: () {
                  if (order.canRate) {
                    Get.toNamed(
                      Routes.ORDER_DETAILS_DELIVERED,
                      arguments: order.id,
                    );
                    return;
                  }

                  if (order.canCancel) {
                    Get.toNamed(
                      Routes.ORDER_DETAILS_UNDERWAY,
                      arguments: order.id,
                    );
                    return;
                  }

                  Get.toNamed(
                    Routes.ORDER_DETAILS_CANCELLED,
                    arguments: order.id,
                  );
                },
              ),
            );
          },
        ),
        onLoading: ListView.builder(
          padding: AppDimension.appPadding,
          itemCount: 4,
          controller: controller.scroll,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: OrderCardView(
                orderNo: '2',
                orderDate: '',
                status: '',
                price: '',
                onTap: () {},
                statusNum: '',
              ).shimmer(),
            );
          },
        ),
        onEmpty: AppPageEmpty.ordersList(),
      ),
    );
  }
}
