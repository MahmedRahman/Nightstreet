import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/orders_list/controllers/orders_list_controller.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class OrderPaymentSuccessView extends GetView {
  const OrderPaymentSuccessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bottomNavigationController = Get.find<MyBottomNavigationController>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppSvgAssets.successIcon,
              height: 100,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'تهانينا !!',
              style: TextStyle(
                fontFamily: 'Effra',
                fontSize: 18.0,
                letterSpacing: 0.9,
                fontWeight: FontWeight.w500,
                height: 0.56,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'تمت العملية بنجاح ، وسنرسل إليك رسالة\nتأكيد عبر البريد الإلكتروني قريبًا.',
              style: TextStyle(
                fontFamily: 'Effra',
                fontSize: 16.0,
                letterSpacing: 0.24,
                height: 2.19,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              child: Column(
                children: [
                  CustomBtnCompenent.main(
                    text: "عرض جميع طلباتي",
                    width: 240,
                    onTap: () {
                      final bottomController =
                          Get.find<MyBottomNavigationController>();

                      bottomController.changePage(4);
                       Get.offAllNamed(Routes.ORDERS_LIST);

                      // Get.toNamed(Routes.ORDERS_LIST);

                      return;
                    },
                  ),
                  AppSpacers.height12,
                  CustomBtnCompenent.secondary(
                    text: 'الرئيسية',
                    width: 240,
                    onTap: () {
                      Get.offAndToNamed(Routes.LAYOUT);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
