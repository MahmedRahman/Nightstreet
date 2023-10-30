import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/cancel_card_view.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/toast_component.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/service_cancel_controller.dart';

class ServiceCancelView extends GetView<ServiceCancelController> {
  ServiceCancelView({Key? key}) : super(key: key);

  final selectedReasonsIds = Rx<List<String>?>([]);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: "الغاء الخدمة",
      ),
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacers.height19,
            Text(
              '- ما السبب في الغاء الخدمة ؟',
              style: TextStyle(
                fontFamily: 'Effra',
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
            AppSpacers.height19,
            Expanded(
              child: controller.obx(
                (cancelReasons) => ListView.separated(
                  itemBuilder: (context, index) {
                    final reason = (cancelReasons as List).elementAt(index);

                    final bool included = selectedReasonsIds.value
                            ?.contains(reason['id'].toString()) ??
                        false;

                    return Obx(() {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CancelCardView(
                          isSelected: selectedReasonsIds.value
                                  ?.contains(reason['id'].toString()) ??
                              false,
                          reason: reason['name'],
                          onTap: () {
                            if (included) {
                              selectedReasonsIds.value
                                  ?.remove(reason['id'].toString());

                              controller.update();
                              return;
                            }
                            selectedReasonsIds.value
                                ?.add(reason['id'].toString());
                            controller.update();
                          },
                        ),
                      );
                    });
                  },
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Divider(),
                  ),
                  itemCount: cancelReasons.length,
                ),
                onLoading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CancelCardView(
                    isSelected: false,
                    reason: 'خلافاَ للإعتقاد السائد فإن لوريم إيبسوم ليس نصاَ',
                    onTap: () {},
                  ).shimmer(),
                ),
              ),
            )
          ],
        ),
      ),
      bottomBarHeight: 143,
      bottomNavigationBar: Container(
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            CustomBtnCompenent.secondary(
              width: 100,
              text: "الغاء",
              onTap: () => Get.back(),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: CustomBtnCompenent.main(
                //width: Get,
                text: "إرسال",
                onTap: () {
                  if ((selectedReasonsIds.value ?? []).isEmpty) {
                    showToast(message: 'الرجاء تحديد اسباب الإلغاء');
                    return;
                  }

                  controller.cancelAppointment(
                    orderId: Get.arguments as String,
                    reasondIds: selectedReasonsIds.value ?? [],
                  );
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
