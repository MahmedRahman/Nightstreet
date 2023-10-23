import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/cancel_card_view.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/order_cancel_controller.dart';

class OrderCancelView extends GetView<OrderCancelController> {
  OrderCancelView({Key? key}) : super(key: key);

  final RxInt selectedBranch = 100.obs;
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: "الغاء الطلب",
      ),
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacers.height19,
            Text(
              '- ما السبب في الغاء الطلب ؟',
              style: TextStyle(
                fontFamily: 'Effra',
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
            AppSpacers.height19,
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CancelCardView(
                        isSelected: selectedBranch.value == index,
                        reason:
                            'خلافاَ للإعتقاد السائد فإن لوريم إيبسوم ليس نصاَ',
                        onTap: () => selectedBranch.value = index,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Divider(),
                ),
                itemCount: 20,
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
                onTap: () => Get.offAllNamed(Routes.LAYOUT),
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
