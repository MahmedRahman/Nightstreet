import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/doctor_card_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_dimens.dart';

import '../controllers/choose_a_doctor_controller.dart';

class ChooseADoctorView extends GetView<ChooseADoctorController> {
  const ChooseADoctorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(titleText: 'اختر الطبيب'),
      body: ListView.separated(
        padding: AppDimension.appPadding,
        itemBuilder: (context, index) {
          return DoctorCardView.dummy(
            onTap: () => Get.toNamed(Routes.BOOKING_APPOINTMENT),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: 10,
      ),
    );
  }
}
