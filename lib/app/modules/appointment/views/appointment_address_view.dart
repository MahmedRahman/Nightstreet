import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_drop_menu_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import '../appointment_address_controller.dart';

class AppointmentAddressView extends GetView<AppointmentController> {
  var service;

  AppointmentAddressView() {
    service = Get.find<AppointmentController>().service;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: 'حدد الفرع',
      ),
      body: ListView(
        padding: AppDimension.appPadding,
        children: [
          AppSpacers.height25,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'اختر الفرع',
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.blackColor,
                  letterSpacing: 0.32,
                  fontWeight: FontWeight.w500,
                  height: 0.75,
                ),
                textAlign: TextAlign.right,
              ),
              AppSpacers.height10,
              branchesListItem(
                onBranchChanged: (index) {
                  Get.find<AppointmentController>().selectBranch = service["branches"][index];
                },
                data: service["branches"],
              ),
              Divider(),
              AppSpacers.height16,
              DecoratedContainer(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      paymentSumaryItem(
                        title: "اسم العيادة/المركز",
                        value: service["clinic"]["name"],
                      ),
                      AppSpacers.height16,
                      paymentSumaryItem(
                        title: "سعر الحجز",
                        value: "${service["price"]} رس",
                      ),
                      AppSpacers.height16,
                      paymentSumaryItem(
                        title: "ما سيتم دفعه الان",
                        value: "${service["amount_to_pay"]} رس",
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
                        value: "${service["price"] - service["amount_to_pay"]} رس",
                        textColor: AppColors.mainColor,
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacers.height16,
            ],
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
                text: "مواصلة الحجز",
                onTap: () {
                  Get.find<AppointmentController>().branchOfferDoctors();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  CustomDropMenuView<String> citySelector({
    required Function(String) onCityChanged,
  }) {
    return CustomDropMenuView<String>(
      requiredFiled: true,
      labelText: "اختر المدينة",
      itemAsString: (String? u) => u!,
      items: ['الرياض', 'جده', 'الدمام'],
      onChanged: (String? selectedCity) {
        onCityChanged(selectedCity ?? '');
      },
      dropdownBuilder: (_, String? title) {
        return Text(
          title ?? "اختر المدينة",
          style: title == ''
              ? null
              : TextStyle(
                  fontSize: 16.0,
                  color: AppColors.greyColor,
                ),
        );
      },
      popupItemBuilder: (_, String? title, __) {
        return Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.greyColor,
            ),
          ),
        );
      },
    );
  }

  Widget paymentSumaryItem({
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

Widget branchesListItem({
  required Function(int) onBranchChanged,
  required List data,
}) {
  RxInt selectedBranch = 0.obs;
  return Column(
    children: List.generate(
      data.length,
      (index) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Obx(
          () => InkWell(
            onTap: () {
              selectedBranch.value = index;
              onBranchChanged(index);
            },
            child: DecoratedContainer(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 18.0,
                      height: 18.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: selectedBranch.value == index ? AppColors.mainColor : Colors.transparent,
                        border: Border.all(
                          width: 1.0,
                          color: AppColors.greyColor.withOpacity(0.4),
                        ),
                      ),
                      child: selectedBranch.value == index
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            )
                          : SizedBox.shrink(),
                    ),
                    AppSpacers.width10,
                    Text(
                      data[index]["name"],
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.blackColor,
                        letterSpacing: 0.24,
                        height: 0.75,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
