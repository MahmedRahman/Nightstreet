import 'package:app_night_street/core/component/custom_base_scaffold.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/map_permission_controller.dart';

class MapPermissionView extends GetView<MapPermissionController> {
  const MapPermissionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          Spacer(),
          SvgPicture.asset(
            "images/svg/location.svg",
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'تحديد الموقع الخاص بك',
            style: TextStyles.font17boldBlack,
          ),
          SizedBox(
            height: 12,
          ),
          SizedBox(
            child: Text(
              'من أجل تجربة أفضل ، يرجي تحديد الموقع الخاص بك او يمكنك السماح للتطبيق بتحديده تلقائيا',
              style: TextStyles.font13regularBlack.copyWith(
                height: 2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          CustomButton.fill(
            title: "السماح للتطبيق",
          ),
          SizedBox(
            height: 12,
          ),
          CustomButton.outLine(
            title: "تحديده يدويا",
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
