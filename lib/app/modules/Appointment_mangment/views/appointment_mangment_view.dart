import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/closed_appointment_list_view.dart';
import 'package:krzv2/component/views/current_appointment_list_view.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/tabs/base_switch_tap.dart';
import 'package:krzv2/utils/app_dimens.dart';

import '../controllers/appointment_mangment_controller.dart';

class AppointmentMangmentView extends GetView<AppointmentMangmentController> {
  AppointmentMangmentView({Key? key}) : super(key: key);

  final RxInt selectedTapIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(titleText: "مواعيدي"),
      onRefresh: () async {
        if (selectedTapIndex.value == 0) {
          // 1 for current appointment
          controller.fetchAppointmentByType(1);
          return;
        }
        // 2 for current appointment
        controller.fetchAppointmentByType(2);
      },
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          children: [
            BaseSwitchTap(
              title1: "مواعيدي الحالية",
              title2: "مواعيدي المنتهية",
              Widget1: CurrentAppointmentListView(),
              Widget2: ClosedAppointmentListView(),
              onTap: (int index) {
                selectedTapIndex.value = index;
                controller.fetchAppointmentByType(index == 0 ? 1 : 2);
              },
            ),
          ],
        ),
      ),
    );
  }
}
