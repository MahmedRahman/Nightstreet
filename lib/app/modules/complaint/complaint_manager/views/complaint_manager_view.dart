import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/complaint/complaint_active_list/controllers/complaint_active_list_controller.dart';
import 'package:krzv2/app/modules/complaint/complaint_active_list/views/complaint_active_list_view.dart';
import 'package:krzv2/app/modules/complaint/complaint_closed_list/controllers/complaint_closed_list_controller.dart';
import 'package:krzv2/app/modules/complaint/complaint_closed_list/views/complaint_closed_list_view.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/tabs/base_switch_tap.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_dimens.dart';

import '../controllers/complaint_manager_controller.dart';

class ComplaintManagerView extends GetView<ComplaintManagerController> {
  ComplaintManagerView({Key? key}) : super(key: key);

  final RxInt selectedTap = 0.obs;
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      onRefresh: () async {
        if (selectedTap.value == 0) {
          ComplaintActiveListController controller =
              Get.put(ComplaintActiveListController());
          controller.resetPaginationData();
          controller.getComplaints();
          return;
        }

        ComplaintClosedListController controller =
            Get.put(ComplaintClosedListController());
        controller.resetPaginationData();
        controller.getComplaints();
      },
      appBar: CustomAppBar(
        titleText: "تواصل معنا",
      ),
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          children: [
            BaseSwitchTap(
              title1: 'الشكاوي الحالية',
              title2: 'الشكاوي المغلقة',
              Widget1: ComplaintActiveListView(),
              Widget2: ComplaintClosedListView(),
              onTap: (int index) {
                selectedTap.value = index;
                if (index == 0) {
                  ComplaintActiveListController controller =
                      Get.put(ComplaintActiveListController());
                  controller.getComplaints();
                  return;
                }

                ComplaintClosedListController controller =
                    Get.put(ComplaintClosedListController());

                controller.getComplaints();
              },
            ),
          ],
        ),
      ),
      bottomBarHeight: 150,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: CustomBtnCompenent.main(
          text: 'أضف شكوى جديدة',
          onTap: () => Get.toNamed(Routes.COMPLAINT_ADD_NEW),
        ),
      ),
    );
  }
}
