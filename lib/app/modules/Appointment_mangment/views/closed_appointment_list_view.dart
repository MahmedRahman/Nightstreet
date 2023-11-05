import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/appointment_mangment/controllers/appointment_mangment_controller.dart';
import 'package:krzv2/component/views/appointment_card_view.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/appointment_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ClosedAppointmentListView extends GetView<AppointmentMangmentController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (List<AppointmentModel>? appointmentList) => ListView.builder(
        controller: controller.scroll,
        itemCount: appointmentList?.length,
        itemBuilder: (context, index) {
          final appointment = appointmentList!.elementAt(index);
          return AppointmentCardView(
            status: appointment.status,
            offerName: appointment.offer.name,
            offerImage: appointment.offer.image,
            offerPrice: appointment.offer.price.toString(),
            offerOldPrice: appointment.offer.oldPrice.toString(),
            doctorName: appointment.doctorName,
            clinicName: appointment.ClinicName,
            dateTime: appointment.datetime,
            mainButtonText: "تقييم الخدمة",
            secondButtonText: "تحميل الفاتورة",
            mainButtonOnTap: () {
              
              Get.toNamed(
                Routes.SERVICE_REVIEW,
                arguments: appointment,
              );
            },
            secondButtonOnTap: () {},
            id: appointment.id.toString(),
          ).paddingOnly(bottom: 10);
        },
      ),
      onLoading: ListView(
        children: [
          AppointmentCardView.dummy().shimmer(),
          AppSpacers.height10,
        ],
      ),
      onEmpty: AppPageEmpty.appointment(
        title: 'لا توجد مواعيد منتهية',
        description: "لم يتم تسجيل أي مواعيد. يمكنك الآن الحجز \n والاستفادة من العروض شكرًا لاختيار خدماتنا.",
      ),
    );
  }
}
