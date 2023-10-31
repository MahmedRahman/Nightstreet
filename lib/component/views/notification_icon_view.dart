import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/icon_button_component.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class NotificationIconView extends GetView {
  const NotificationIconView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
      builder: (controller) {
        return CustomIconButton(
          onTap: () {
            Get.toNamed(Routes.notificationPage);
          },
          iconPath: AppSvgAssets.notificationIcon,
          count: controller.userData?.notificationsCount ?? 0,
        );
      },
    );
  }
}
