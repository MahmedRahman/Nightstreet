import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:krzv2/app/modules/appointment/appointment_address_controller.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/custom_drop_menu_view.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/component/views/date_time_form_field_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/service_information_view.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

class AppointmentBookingView extends GetView<AppointmentController> {
  bool isDoctorSelect;
  var serves;
  var selectDoctor;
  TextEditingController longText = TextEditingController();

  AppointmentBookingView({
    required this.isDoctorSelect,
  }) {
    serves = Get.find<AppointmentController>().service;
    selectDoctor = Get.find<AppointmentController>().selectDoctor;
  }

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
          isDoctorSelect
              ? ServiceInformationView(
                  serviceName: serves["name"],
                  doctorName: selectDoctor["name"],
                )
              : SizedBox.shrink(),
          AppSpacers.height12,
          Divider(),
          AppSpacers.height12,
          // monthSelector(
          //   onMonthChanged: (String) {},
          // ),
          DateTimeFormFieldView(
            title: "تاريخ ",
            initialDateTime: "",
            firstDate: DateTime.now(),
            onDateChanged: (DateTime value) {
              //print(formattedDate.toString());
              String valData = "${value.year}-${value.month}-${value.day}";
              Get.find<AppointmentController>().selectData = valData.toString();
              Get.find<AppointmentController>().selectTime = "";
              Get.find<AppointmentController>().getAvailableOfferTimes();

              //birthDateController.text = value.toString().substring(0, 10);
            },
          ),
          AppSpacers.height19,
          Obx(() {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.mainColor,
                ),
              ),
              child: controller.AppointmentDataList.length == 0
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text("لا يوجد مواعيد"),
                      ),
                    )
                  : Wrap(
                      children: List.generate(
                        controller.AppointmentDataList.length,
                        (index) {
                          return timeCard(
                            onTap: (p0) {
                              Get.find<AppointmentController>().selectTime =
                                  controller.AppointmentDataList[index]["time"];
                              controller.AppointmentDataList.refresh();
                            },
                            time: controller.AppointmentDataList[index]["time"],
                            isSelect: controller.AppointmentDataList[index]["time"] ==
                                Get.find<AppointmentController>().selectTime,
                          );
                        },
                      ),
                    ),
            );
          }),
          AppSpacers.height25,
          // appointmentSelector(
          //   onDayChanged: (int) {},
          // ),
          AppSpacers.height25,
          TextFieldComponent.longMessage(
            controller: longText,
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
                onTap: () {
                  if (Get.find<AppointmentController>().selectTime == "") {
                    AppDialogs.showToast(message: "برجاء اختيار المعاد المناسب");
                    return;
                  }
                  if (Get.find<AppointmentController>().selectData == "") {
                    AppDialogs.showToast(message: "برجاء اختيار التاريخ");
                    return;
                  }

                  controller.AppointmentDataList.value = [];

                  Get.find<AppointmentController>().selectNote = longText.text;
                  Get.toNamed(Routes.PAYMENT_APPOINTMENT);
                },
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
                        color: selectedDay.value == index ? AppColors.mainColor : AppColors.greyColor4,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19),
                        child: Column(
                          children: [
                            Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: selectedDay.value == index ? Colors.white : AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                                height: 1.95,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'السبت',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: selectedDay.value == index ? Colors.white : AppColors.blackColor,
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
                        color: selectedDay.value == index ? AppColors.mainColor : AppColors.greyColor4,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19),
                        child: Center(
                          child: Text(
                            '0${index + 4}:00 ص',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: selectedDay.value == index ? Colors.white : AppColors.blackColor,
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

Widget timeCard({
  required String time,
  required void Function(String)? onTap,
  required bool isSelect,
}) {
  return InkWell(
    onTap: () {
      onTap!(time);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelect ? AppColors.mainColor : Colors.transparent,
          border: Border.all(
            color: AppColors.mainColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            time.toString(),
            style: TextStyle(
              color: isSelect ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    ),
  );
}
