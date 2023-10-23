import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/notification/model/notification_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class NotificationController extends GetxController
    with StateMixin<List<NotificationModel>>, ScrollMixin {
  final List<NotificationModel> _notifications = [];
  int currentPage = 1;
  int? totalRemotePage;

  @override
  void onInit() async {
    change([], status: RxStatus.loading());
    await fetchNotifications();
    super.onInit();
  }

  fetchNotifications() async {
    final ResponseModel responseModel = await WebServices().fetchNotifications(
      page: currentPage,
    );

    if (responseModel.data['success'] == true) {
      final fetchedNotifications = List<NotificationModel>.from(
        responseModel.data['data']['data']
            .map((item) => NotificationModel.fromJson(item)),
      );

      _notifications.addAll(fetchedNotifications);

      if (_notifications.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      await Future.delayed(const Duration(milliseconds: 500));
      change(_notifications, status: RxStatus.success());
      totalRemotePage = responseModel.data['data']['pagination']['total_pages'];
    }
  }

  @override
  Future<void> onEndScroll() async {
    bool hasNext = currentPage < totalRemotePage!;
    if (hasNext == false) return;
    currentPage++;

    Get.dialog(
      const Center(
        child: SpinKitCircle(
          color: AppColors.mainColor,
          size: 70,
        ),
      ),
    );

    await fetchNotifications();

    Get.back();
  }

  @override
  Future<void> onTopScroll() async {}

  String getRelativeTimeString(DateTime providedDateTime) {
    DateTime now = DateTime.now();

    Duration difference = now.difference(providedDateTime);
    int daysDifference = difference.inDays;

    switch (daysDifference) {
      case 0:
        return "اليوم";
      case 1:
        return "منذ يوم";
      case 2:
        return "منذ يومين";
      default:
        return "منذ $daysDifference أيام";
    }
  }
}
