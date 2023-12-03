import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:krzv2/app/modules/appointment/appointment_address_controller.dart';

class AppointmentPaymentView extends GetView<AppointmentController> {
  String? payment_type;
  RxBool KCardStatus = false.obs;
  RxBool KWalletStatus = false.obs;

  @override
  Widget build(BuildContext context) {
    print(Get.find<AppointmentController>().service.toString());

    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: 'موعـد',
      ),
      body: ListView(
        padding: AppDimension.appPadding,
        children: [
          AppSpacers.height12,
          ServiceInformationView(
            serviceName: Get.find<AppointmentController>().service["name"],
            doctorName: GetUtils.isNullOrBlank(
                        Get.find<AppointmentController>().selectDoctor) ==
                    true
                ? ""
                : Get.find<AppointmentController>().selectDoctor["name"],
            clinicName: Get.find<AppointmentController>().service["clinic"]
                ["name"],
            clinicAddress: Get.find<AppointmentController>().service["clinic"]
                ["desc"],
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
                  Get.find<AuthenticationController>()
                              .userData!
                              .walletBalance ==
                          "0"
                      ? SizedBox.shrink()
                      : Obx(() {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Divider(),
                              ),
                              Row(
                                children: [
                                  CustomToggleView(
                                    activeColor: AppColors.mainColor,
                                    deactivateColor: Colors.white,
                                    Kselected: KWalletStatus.value,
                                    onChanged: (bool vlu) {
                                      KWalletStatus.value =
                                          !KWalletStatus.value;
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
                                    'رصيدك الحالي : ${Get.find<AuthenticationController>().userData!.walletBalance}',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: AppColors.greyColor,
                                      letterSpacing: 0.18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Divider(),
                  ),
                  Obx(() {
                    return InkWell(
                      overlayColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      onTap: () {
                        KCardStatus.value = !KCardStatus.value;
                      },
                      child: Row(
                        children: [
                          CustomRadioView(
                            isActive: KCardStatus.value,
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
                    );
                  }),
                ],
              ),
            ),
          ),
          AppSpacers.height12,
          Divider(),
          AppSpacers.height12,
          DecoratedContainer(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AppSpacers.height16,
                  paymentSumaryItem(
                    title: "موعد الحجز",
                    value: '${Get.find<AppointmentController>().selectData}',
                  ),
                  AppSpacers.height16,
                  paymentSumaryItem(
                    title: "المجموع الكلي",
                    value:
                        "${Get.find<AppointmentController>().service["price"]} رس",
                  ),
                  AppSpacers.height16,
                  paymentSumaryItem(
                    title: "ما سيتم دفعه الان",
                    value:
                        "${Get.find<AppointmentController>().service["amount_to_pay"]} رس",
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
                    value:
                        "${Get.find<AppointmentController>().service["price"] - Get.find<AppointmentController>().service["amount_to_pay"]} رس",
                    textColor: AppColors.mainColor,
                  ),
                ],
              ),
            ),
          ),
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
                  if (EasyLoading.isShow) return;
                  // if (Get.find<AuthenticationController>()
                  //         .userData!
                  //         .completeProfile ==
                  //     false) {
                  //   AppDialogs.showToast(message: "برجاء استكمال الملف الشخصي");
                  //   Get.toNamed(Routes.updateProfile);
                  //   return;
                  // }

                  if (KCardStatus.value == false &&
                      KWalletStatus.value == false) {
                    AppDialogs.showToast(message: "برجاء اختيار طريقه الدفع");
                    return;
                  }

                  if (KCardStatus.value == true &&
                      KWalletStatus.value == true) {
                    final walletBalance = num.parse(
                        Get.find<AuthenticationController>()
                            .userData!
                            .walletBalance);

                    print('walletBalance $walletBalance');

                    final amountToPay =
                        (Get.find<AppointmentController>().service["price"] -
                            Get.find<AppointmentController>()
                                .service["amount_to_pay"]);

                    if (walletBalance >= num.parse(amountToPay.toString())) {
                      return AppDialogs.showToast(
                          message: "رصيد المحفظة يكفي إختر طريقة دفع واحدة");
                    }
                    payment_type = "wallet_card";
                  }

                  if (KCardStatus.value == true &&
                      KWalletStatus.value == false) {
                    payment_type = "card";
                  }

                  if (KCardStatus.value == false &&
                      KWalletStatus.value == true) {
                    payment_type = "wallet";
                  }

                  print(payment_type.toString());

                  Get.find<AppointmentController>().bookAppointment(
                    payment_type: payment_type.toString(),
                  );
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
