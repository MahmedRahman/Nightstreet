import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/custom_app_bar.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: CustomAppBar(titleText: 'الاشعارات'),
      child: ListView.builder(
        itemCount: 10,
        padding: AppDimension.appPadding.copyWith(top: 40),
        itemBuilder: (context, index) => notificationItem(
          title: 'عنوان التنبيه',
          message:
              'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص ',
          time: "قبل 5 دقايق",
        ),
      ),
    );
  }

  Container notificationItem({
    required String title,
    required String message,
    required String time,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(11.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0x08000000),
            offset: Offset(0, 5),
            blurRadius: 60,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: const Color(0x17ea3248),
              borderRadius: BorderRadius.circular(11.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x01000000),
                  offset: Offset(0, 5),
                  blurRadius: 60,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "images/svg/Notification.svg",
                color: Color(0xffEA3248),
              ),
            ),
          ),
          const SizedBox(width: 13),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.font14RegularBlack,
              ),
              const SizedBox(height: 5),
              Container(
                constraints: BoxConstraints(
                  maxWidth: Get.width * .7,
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 11,
                    color: const Color(0xffababb7),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                time,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 11,
                  color: const Color(0xffababb7),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
