import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/complaint/complaint_details/views/complaint_details_view.dart';
import 'package:krzv2/component/views/complant_item_builder_view.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/complaint_model.dart';

import '../controllers/complaint_closed_list_controller.dart';

class ComplaintClosedListView extends GetView<ComplaintClosedListController> {
  ComplaintClosedListView({Key? key}) : super(key: key);
  final controller = Get.put(ComplaintClosedListController());
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (List<ComplaintModel>? complaints) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          controller: controller.scroll,
          itemCount: complaints!.length,
          itemBuilder: (context, index) {
            final complaint = complaints.elementAt(index);
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
              ),
              child: ComplantItemBuilderView(
                complaintDate: complaint.date,
                complaintId: '#${complaint.id}',
                isActiveComplaint: false,
                statusTitle: complaint.status,
                onTap: () {
                  Get.to(ComplaintDetailsView(complaint.id.toString()));
                },
              ),
            );
          },
        );
      },
      onLoading: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
            ),
            child: ComplantItemBuilderView(
              complaintDate: DateTime.now(),
              complaintId: '',
              isActiveComplaint: false,
              statusTitle: '',
              onTap: () {},
            ),
          ).shimmer();
        },
      ),
      onEmpty: AppPageEmpty.complaint(
        title: "الشكاوي المغلقه",
        description: "لا يوجد شكاوي مغلقه",
      ),
    );
  }
}
