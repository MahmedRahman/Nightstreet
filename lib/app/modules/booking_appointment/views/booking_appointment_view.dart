import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_drop_menu_view.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/service_information_view.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/booking_appointment_controller.dart';

class BookingAppointmentView extends GetView<BookingAppointmentController> {
  BookingAppointmentView({Key? key}) : super(key: key);
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
          ),
          AppSpacers.height12,
          Divider(),
          AppSpacers.height12,
          monthSelector(
            onMonthChanged: (String) {},
          ),
          AppSpacers.height19,
          daySelector(
            onDayChanged: (int) {},
          ),
          AppSpacers.height25,
          appointmentSelector(
            onDayChanged: (int) {},
          ),
          AppSpacers.height25,
          TextFieldComponent.longMessage(
            controller: TextEditingController(),
            outLineText: "تفاصيل إضافية",
            hintText: "أكتب التفاصيل هنا",
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
                text: 'مواصلة الحجز',
                onTap: () => Get.toNamed(Routes.PAYMENT_APPOINTMENT),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column daySelector({
    required Function(int) onDayChanged,
  }) {
    RxInt selectedDay = 0.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'حدد اليوم',
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
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 31,
            itemBuilder: (context, index) {
              return Obx(
                () => Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: InkWell(
                    overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    onTap: () {
                      selectedDay.value = index;
                      onDayChanged(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: selectedDay.value == index
                            ? AppColors.mainColor
                            : AppColors.greyColor4,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19),
                        child: Column(
                          children: [
                            Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: selectedDay.value == index
                                    ? Colors.white
                                    : AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                                height: 1.95,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'السبت',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: selectedDay.value == index
                                    ? Colors.white
                                    : AppColors.blackColor,
                                letterSpacing: 0.35000000000000003,
                                height: 1.64,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Column appointmentSelector({
    required Function(int) onDayChanged,
  }) {
    RxInt selectedDay = 0.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المواعيد المتاحة',
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
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 31,
            itemBuilder: (context, index) {
              return Obx(
                () => Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: InkWell(
                    overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    onTap: () {
                      selectedDay.value = index;
                      onDayChanged(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: selectedDay.value == index
                            ? AppColors.mainColor
                            : AppColors.greyColor4,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19),
                        child: Center(
                          child: Text(
                            '0${index + 4}:00 ص',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: selectedDay.value == index
                                  ? Colors.white
                                  : AppColors.blackColor,
                              letterSpacing: 0.35000000000000003,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  CustomDropMenuView<String> monthSelector({
    required Function(String) onMonthChanged,
  }) {
    return CustomDropMenuView<String>(
      requiredFiled: true,
      labelText: 'اختر الشهر',
      itemAsString: (String? u) => u!,
      items: ['يناير', 'فبراير', 'مارس'],
      onChanged: (String? selectedMonth) {
        onMonthChanged(selectedMonth ?? '');
      },
      dropdownBuilder: (_, String? title) {
        return Text(
          title ?? "اختر الشهر",
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
}
