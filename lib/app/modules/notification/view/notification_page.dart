import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/pages/app_page_loading_more.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/component/views/notification_component.dart';
import 'package:krzv2/app/modules/notification/controller/notifications_controller.dart';
import 'package:krzv2/utils/app_colors.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: "الإشعارات",
        actions: [],
      ),
      body: controller.obx(
        (notifications) {
          return ListView.separated(
            controller: controller.scroll,
            itemCount: notifications!.length,
            padding: AppDimension.appPadding +
                const EdgeInsets.symmetric(vertical: 30),
            itemBuilder: (context, index) {
              if (index == notifications.length - 1 &&
                          notifications.length != 1) {
                return AppPageLoadingMore(
                  display: controller.status.isLoadingMore,
                );
              }

              return NotificationBuilderWidget(
                iconPath: notifications[index].icon,
                notificationTitle: notifications[index].title,
                notificationDescription: notifications[index].body,
                notificationTime: notifications[index].createdAt.toString(),
                isRead: notifications[index].isRead == 1 ? true : false,
                onTap: () {
                  if (notifications[index].isRead == 0) {
                    controller.readNotifications(notifications[index].id);
                  }

                  if (notifications[index].clickAction == "appointments") {
                    Get.toNamed(Routes.APPOINTMENT_MANGMENT);
                    return;
                  }

                  if (notifications[index].clickAction == "orders") {
                    Get.toNamed(
                      Routes.ORDER_DETAILS_DELIVERED,
                      arguments: notifications[index].redirectId,
                    );
                    //OrderDetailsDeliveredView
                    return;
                  }

                  return;
                },
              );
            },
            separatorBuilder: (_, __) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(),
            ),
          );
        },
        onLoading: const Center(
          child: Center(
            child: SpinKitCircle(
              color: AppColors.mainColor,
              size: 70,
            ),
          ),
        ),
        onEmpty: AppPageEmpty.notifications(),
        onError: (error) => Center(
          child: Text(
            'Error: Cannot get repositories \n$error',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
