import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/appointment/appointment_address_controller.dart';
import 'package:krzv2/app/modules/appointment/views/appointment_booking_h_view.dart';
import 'package:krzv2/app/modules/appointment/views/appointment_booking_view.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/doctor_card_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/utils/app_dimens.dart';

class AppointmentChooseDoctorView extends GetView<AppointmentController> {
  final List data;
  final serves;
  AppointmentChooseDoctorView({
    required this.data,
    required this.serves,
  });
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(titleText: 'اختر الطبيب'),
      body: ListView.separated(
        padding: AppDimension.appPadding,
        itemBuilder: (context, index) {
          return DoctorCardView(
            onTap: () {
              Get.find<AppointmentController>().selectDoctor = data[index];
              Get.to(() => AppointmentBookingHView(
                    isDoctorSelect: true,
                  ));
            },
            doctorName: data[index]["name"].toString(),
            doctorImage: data[index]["image"].toString(),
            doctorJob: data[index]["speciality"].toString(),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: data.length,
      ),
    );
  }
}
