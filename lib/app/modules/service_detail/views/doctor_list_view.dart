import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/service_detail/controllers/doctor_controller.dart';
import 'package:krzv2/component/views/doctor_card_view.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/routes/app_pages.dart';

class DoctorListView extends GetView {
  DoctorController controller = Get.put(DoctorController());
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الأطباء الذين يقدمون هذه الخدمة',
              style: TextStyle(
                fontFamily: 'Effra',
                fontSize: 16.0,
                letterSpacing: 0.24,
                fontWeight: FontWeight.w500,
                height: 0.75,
              ),
              textAlign: TextAlign.right,
            ),
            Column(
              children: List.generate(
                snapshot!.length,
                (index) {
                  return DoctorCardView(
                    doctorName: snapshot.elementAt(index)["name"],
                    doctorJob: snapshot.elementAt(index)["speciality"],
                    doctorImage: snapshot.elementAt(index)["image"],
                    onTap: () {
                      Get.toNamed(
                        Routes.ABOUT_DOCTOR,
                        arguments: snapshot.elementAt(index),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
      onLoading: DoctorCardView.dummy().shimmer(),
      onEmpty: AppPageEmpty.ordersList(),
    );
  }
}
