import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/custom_radio_view.dart';
import 'package:krzv2/component/views/custom_toggle_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/service_information_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/payment_appointment_controller.dart';

class PaymentAppointmentView extends GetView<PaymentAppointmentController> {
  const PaymentAppointmentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: 'احجـز موعـد',
      ),
      body: ListView(
        padding: AppDimension.appPadding,
        children: [
          AppSpacers.height12,
          ServiceInformationView(
            serviceName:
                'تمتعي ببشرة مشرقة خالية من التجاعيد بنتائج سريعة\nو مزهلة',
            doctorName: 'محمد بدر',
            clinicName: 'مركز طيبة للتجميل',
            clinicAddress: "فرع (2) المنطقة الثانية، شارع الرياض",
          ),
          AppSpacers.height12,
          Divider(),
          AppSpacers.height12,
          DecoratedContainer(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppSvgAssets.blackWalletIcon),
                      AppSpacers.width10,
                      Text(
                        "اختر طريقة الدفع",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.blackColor,
                          letterSpacing: 0.16,
                          height: 0.75,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Divider(),
                  ),
                  Row(
                    children: [
                      CustomToggleView(
                        activeColor: AppColors.mainColor,
                        deactivateColor: Colors.white,
                        onChanged: (bool vlu) {
                          log('data => $vlu');
                        },
                      ),
                      AppSpacers.width10,
                      Text(
                        'محفظة كرز',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: AppColors.blackColor,
                          letterSpacing: 0.28,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'رصيدك الحالي : 120',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: AppColors.greyColor,
                          letterSpacing: 0.18,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Divider(),
                  ),
                  InkWell(
                    overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    onTap: () {},
                    child: Row(
                      children: [
                        CustomRadioView(
                          isActive: false,
                        ),
                        AppSpacers.width10,
                        Text('البطاقات الإئتمانية'),
                        Spacer(),
                        Row(
                          children: [
                            SvgPicture.asset(AppSvgAssets.applePayIcon),
                            AppSpacers.width5,
                            SvgPicture.asset(AppSvgAssets.madaIcon),
                            AppSpacers.width5,
                            SvgPicture.asset(AppSvgAssets.visaIcon),
                            AppSpacers.width5,
                            SvgPicture.asset(AppSvgAssets.masterIcon),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // AppSpacers.height16,
          // CouponForm(
          //   onTap: (String code) {},
          // ),
          AppSpacers.height12,
          Divider(),
          AppSpacers.height12,
          DecoratedContainer(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  paymentSumaryItem(
                    title: "رقم الحجز",
                    value: '#13776',
                  ),
                  AppSpacers.height16,
                  paymentSumaryItem(
                    title: "موعد الحجز",
                    value: 'الثلاثــاء، 22 مارس 2022م',
                  ),
                  AppSpacers.height16,
                  paymentSumaryItem(
                    title: "المجموع الكلي",
                    value: "1760 رس",
                  ),
                  AppSpacers.height16,
                  paymentSumaryItem(
                    title: "ما سيتم دفعه الان",
                    value: "1760 رس",
                  ),
                  AppSpacers.height12,
                  DottedLine(
                    dashLength: 10,
                    dashGapLength: 5,
                    lineThickness: 3,
                    dashColor: AppColors.borderColor2,
                  ),
                  AppSpacers.height12,
                  paymentSumaryItem(
                    title: "المبلغ المتبقي",
                    value: "1000 رس",
                    textColor: AppColors.mainColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomBarHeight: 155,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomBtnCompenent.secondary(
                text: "الغاء",
                onTap: () => Get.back(),
              ),
            ),
            AppSpacers.width10,
            Expanded(
              flex: 3,
              child: CustomBtnCompenent.main(
                text: "تأكيد الدفع",
                onTap: () {
                  AppDialogs.appointmentBookingSuccess();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row paymentSumaryItem({
    required String title,
    required String value,
    Color? textColor = Colors.black,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.blackColor,
            height: 1.36,
          ),
          textAlign: TextAlign.right,
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.0,
            color: textColor,
            height: 1.36,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
