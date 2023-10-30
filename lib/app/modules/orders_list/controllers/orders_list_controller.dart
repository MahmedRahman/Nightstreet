import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/models/order_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class OrdersListController extends GetxController
    with StateMixin<List<OrderModel>>, ScrollMixin {
  final List<OrderModel> _orders = [];
  int currentPage = 1;
  bool? isPagination;

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  void refreshList() {
    currentPage = 1;
    _orders.clear();
    getOrders();
  }

  getOrders() async {
    if (currentPage == 1) change([], status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getOrders(
      pageNo: currentPage,
    );

    if (responseModel.data["success"]) {
      final List<OrderModel> ordersDataList = List<OrderModel>.from(
        responseModel.data['data']['data']
            .map((category) => OrderModel.fromJson(category)),
      );

      _orders.addAll(ordersDataList);

      if (_orders.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(_orders, status: RxStatus.success());

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
    }
  }

  @override
  Future<void> onEndScroll() async {
    if (isPagination == false) return;
    currentPage++;

    Get.dialog(
      const Center(
        child: SpinKitCircle(
          color: AppColors.mainColor,
          size: 70,
        ),
      ),
    );

    await getOrders();

    Get.back();
  }

  @override
  Future<void> onTopScroll() async {
    print('onTopScroll');
  }
}
