import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/service_detail/controllers/doctor_controller.dart';
import 'package:krzv2/component/views/doctor_card_view.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/extensions/widget.dart';

class DoctorListView extends GetView {
  DoctorController controller = Get.put(DoctorController());
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (snapshot) {
        print(snapshot!.length.toString());

        return Column(
          children: List.generate(
            snapshot.length,
            (index) {
              return DoctorCardView(
                doctorName: snapshot.elementAt(index)["name"],
                doctorJob: snapshot.elementAt(index)["speciality"],
                doctorImage: snapshot.elementAt(index)["image"],
                onTap: () {},
              );
            },
          ),
        );
      },
      onLoading: DoctorCardView.dummy().shimmer(),
      onEmpty: AppPageEmpty.ordersList(),
    );
  }
}
