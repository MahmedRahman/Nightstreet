import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:krzv2/app/modules/notification/controller/notifications_controller.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class NotificationBuilderWidget extends StatelessWidget {
  const NotificationBuilderWidget({
    super.key,
    required this.notificationTitle,
    this.iconPath,
    this.notificationDescription,
    this.notificationTime,
    this.isRead,
  });

  final String notificationTitle;
  final String? iconPath;
  final String? notificationDescription;
  final String? notificationTime;
  final bool? isRead;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 52,
                  height: 52,
                  child: iconPath == null ? const SizedBox.shrink() : Image.network(iconPath ?? ''),
                ),
                AppSpacers.width10,
                _buildNotificationTitleTime(),
              ],
            ),
            const Spacer(),
            Visibility(
              visible: !isRead!,
              child: _buildNotificationStatus(),
            ),
          ],
        ),
        AppSpacers.height19,
        Text(
          notificationDescription!,
          style: const TextStyle(
            fontSize: 14.0,
            color: AppColors.greyColor,
            height: 1.79,
          ),
        ),
      ],
    );
  }

  Container _buildNotificationStatus() {
    return Container(
      width: 46.0,
      height: 24.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: AppColors.greenColor,
      ),
      child: const Center(
        child: Text(
          'جديد',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            letterSpacing: 0.14,
            height: 0.86,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Widget _buildNotificationTitleTime() {
    DateTime dateTime = DateFormat("yyyy-MM-dd hh:mm a").parse(notificationTime!);

    String outputFormat = "HH:mm a";
    String outputDateTime = DateFormat(outputFormat, 'ar').format(dateTime);

    if (notificationTime == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notificationTitle,
          style: const TextStyle(
            fontSize: 14.0,
            color: AppColors.blackColor,
            letterSpacing: 0.28,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.right,
        ),
        AppSpacers.height10,
        Row(
          children: [
            GetBuilder<NotificationController>(
              builder: (controller) {
                return Text(
                  controller.getRelativeTimeString(dateTime),
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: AppColors.greyColor,
                  ),
                  textAlign: TextAlign.right,
                );
              },
            ),
            AppSpacers.width10,
            Container(
              width: 2,
              height: 18,
              decoration: const BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            AppSpacers.width10,
            Text(
              outputDateTime,
              style: const TextStyle(
                fontSize: 13.0,
                color: AppColors.greyColor,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        )
      ],
    );
  }
}
