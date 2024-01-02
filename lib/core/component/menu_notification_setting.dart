import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MenuNotificationSetting extends GetView {
  MenuNotificationSetting({
    super.key,
    required this.onNotificationChanged,
  });

  final Function(bool) onNotificationChanged;

  final RxBool notificationIsActive = false.obs;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المعلومات الاساسية',
          style: TextStyles.font14mediumBlack.copyWith(
            color: const Color(0xff666c89),
          ),
        ),
        const SizedBox(height: 17),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              children: [
                SvgPicture.asset("images/svg/notification_icon.svg"),
                const SizedBox(width: 15),
                Text(
                  'الاشعارات',
                  style: TextStyles.font14mediumBlack,
                ),
                const Spacer(),
                Obx(
                  () => Switch.adaptive(
                    value: notificationIsActive.value,
                    onChanged: (newVlu) {
                      notificationIsActive.value = newVlu;
                      onNotificationChanged(newVlu);
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
