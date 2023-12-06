import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/appointment/views/appointment_booking_view.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/custom_drop_menu_view.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/component/views/date_time_form_field_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/edit_appointment_controller.dart';

// EditAppointmentView({
//   required this.initialDateTime,
// });
class EditAppointmentView extends GetView<EditAppointmentController> {
  EditAppointmentController controller = Get.put(EditAppointmentController());

  // EditAppointmentView() {
  //   Get.find<AppointmentController>().selectData = "";
  //   Get.find<AppointmentController>().selectTime = "";
  //   Get.find<AppointmentController>().selectTimeUI.value = "";
  //   Get.find<AppointmentController>().selectDateUI.value = "";

  //   Get.find<AppointmentController>().selectNote = "";
  // }

  // String? selectDate = "";
  // String? selectTime = "";

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    TextEditingController longText = TextEditingController(
      text: controller.appointment!.notes.toString(),
    );
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: "تعديل الموعد",
      ),
      body: ListView(
        padding: AppDimension.appPadding,
        children: [
          AppSpacers.height12,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(
                  () => DateTimeFormFieldView(
                    title: "تاريخ ",
                    initialDateTime: controller.selectData.value,
                    firstDate: DateTime.now(),
                    onDateChanged: (DateTime value) {
                      var month = value.month.toString();

                      if (month.length == 1) {
                        month = "0${month}";
                      }
                      var day = value.day.toString();

                      if (day.length == 1) {
                        day = "0${day}";
                      }

                      String valData = "${value.year}-${month}-${day}";

                      Get.find<EditAppointmentController>().selectData.value =
                          valData.toString();

                      Get.find<EditAppointmentController>().selectTime = "";
                      Get.find<EditAppointmentController>().selectTimeUI.value =
                          "";

                      Get.find<EditAppointmentController>()
                          .getAvailableOfferTimes();

                      //Get.find<EditAppointmentController>(). selectDate = value.toString().substring(0, 10);
                    },
                  ),
                ),
              ),
              AppSpacers.width10,
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (controller.selectData == "") {
                      return AppDialogs.showToast(message: 'اختيار تاريخ');
                    }

                    if (controller.AppointmentDataList.length == 0) {
                      return AppDialogs.showToast(message: 'لا يوجود مواعيد');
                    }

                    Get.generalDialog(
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(Get.context!)
                          .modalBarrierDismissLabel,
                      barrierColor: Colors.black45,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return Center(
                          child: Container(
                            width: Get.width * .8,
                            constraints: BoxConstraints(
                              maxHeight: Get.height * 0.8,
                            ),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'اختر الموعد المناسب',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.blackColor,
                                        letterSpacing: 0.3,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () => Get.back(),
                                      child: Container(
                                        alignment: Alignment(0.03, 0.0),
                                        width: 28.0,
                                        height: 28.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.greyColor4,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: AppColors.greyColor,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                AppSpacers.height25,
                                controller.AppointmentDataList.length == 0
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text("لا يوجد مواعيد"),
                                        ),
                                      )
                                    : Obx(
                                        () => Wrap(
                                          children: List.generate(
                                            controller
                                                .AppointmentDataList.length,
                                            (index) {
                                              return timeCard(
                                                onTap: (p0) {
                                                  Get.find<
                                                          EditAppointmentController>()
                                                      .selectTime = controller
                                                          .AppointmentDataList[
                                                      index]["time"];
                                                  Get.find<
                                                          EditAppointmentController>()
                                                      .selectTimeUI
                                                      .value = controller
                                                          .AppointmentDataList[
                                                      index]["time"];
                                                  Get.find<
                                                          EditAppointmentController>()
                                                      .AppointmentDataList
                                                      .refresh();
                                                  Get.back();
                                                },
                                                time: Get.find<
                                                            EditAppointmentController>()
                                                        .AppointmentDataList[
                                                    index]["time"],
                                                isSelect: Get.find<
                                                                EditAppointmentController>()
                                                            .AppointmentDataList[
                                                        index]["time"] ==
                                                    Get.find<
                                                            EditAppointmentController>()
                                                        .selectTime,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  overlayColor: MaterialStatePropertyAll(Colors.transparent),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الموعد',
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
                      Container(
                        width: double.infinity,
                        height: 52.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xffF5F6FA),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset(AppSvgAssets.timeIcon),
                            SizedBox(
                              width: 15,
                            ),
                            Obx(() {
                              return Text(
                                controller.selectTimeUI.value.toString(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColors.greyColor,
                                  letterSpacing: 0.48,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          AppSpacers.height12,
          TextFieldComponent.longMessage(
            controller: longText,
            outLineText: "تفاصيل إضافية",
            hintText: "أكتب التفاصيل هنا",
          ),
          AppSpacers.height12,
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
                text: "تأكيد الموعد",
                onTap: () {
                  if (controller.appointment!.can_update == false) {
                    AppDialogs.showToast(
                        message: "برجاء التواصل مع الاداره للتعديل المعاد");
                    return;
                  }

                  controller.editAppointments(
                    appointmentID: controller.appointment!.id.toString(),
                    time: controller.selectTime.toString(),
                    dateTime: controller.selectData.toString(),
                    notes: controller.selectData.toString(),
                  );

                  // () => AppDialogs.appointmentUpdateBookingSuccess()
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
