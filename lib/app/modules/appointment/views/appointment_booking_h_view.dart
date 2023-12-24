import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:krzv2/app/modules/appointment/appointment_address_controller.dart';
import 'package:krzv2/app/modules/appointment/views/appointment_data_view.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

final Rx<DateTime?>? selectDate = Rx<DateTime?>(null);
RxBool IsSelect = false.obs;

class AppointmentBookingHView extends GetView<AppointmentController> {
  bool isDoctorSelect = false;
  var serves;
  var selectDoctor;

  AppointmentBookingHView({
    required this.isDoctorSelect,
  }) {
    Get.find<AppointmentController>().selectData = "";
    Get.find<AppointmentController>().selectTime = "";
    Get.find<AppointmentController>().selectTimeUI.value = "";
    Get.find<AppointmentController>().selectDateUI.value = "";
    Get.find<AppointmentController>().selectNote = "";
    Get.find<AppointmentController>().getNonDates.clear();
    Get.find<AppointmentController>().AppointmentDataList.clear();

    serves = Get.find<AppointmentController>().service;
    selectDoctor = Get.find<AppointmentController>().selectDoctor;

    Get.find<AppointmentController>().getAvailableOfferDays();
    focusDate.value = null;
  }

  final focusDate = Rx<DateTime?>(DateTime.now());
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: 'احجـز موعـد',
      ),
      body: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اختر الوقت',
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpacers.height25,
            isDoctorSelect
                ? doctorInfo(
                    name: selectDoctor["name"],
                    image: selectDoctor["image"],
                  )
                : SizedBox.fromSize(),
            AppSpacers.height25,
            customDateTimeLine(
              customOnTap: (selectedDate) {
                // bool isExistInBlockDates = controller.getNonDates
                //     .contains(DateTime(selectedDate.year, selectedDate.month, selectedDate.day));

                // if (isExistInBlockDates) return;
                focusDate.value = selectedDate;
                var month = selectedDate.month.toString();

                if (month.length == 1) {
                  month = "0${month}";
                }
                var day = selectedDate.day.toString();

                if (day.length == 1) {
                  day = "0${day}";
                }

                String valData = "${selectedDate.year}-${month}-${day}";

                print(valData.toString());
                Get.find<AppointmentController>().selectData =
                    valData.toString();
                Get.find<AppointmentController>().selectTime = "";
                Get.find<AppointmentController>().selectTimeUI.value = "";

                Get.find<AppointmentController>().getAvailableOfferTimes();
              },
            ),
            Divider(),
            Expanded(
              child: Obx(() {
                if (controller.timeLoading.value)
                  return Center(child: CupertinoActivityIndicator());
                if (controller.AppointmentDataList.length == 0)
                  return Center(
                      child: Text(
                    "لا يوجد بيانات ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ));

                return ListView.separated(
                  itemCount: controller.AppointmentDataList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Get.find<AppointmentController>().selectTime =
                            controller.AppointmentDataList[index]["time"];
                        Get.find<AppointmentController>().selectTimeUI.value =
                            controller.AppointmentDataList[index]["time"];
                        Get.find<AppointmentController>()
                            .AppointmentDataList
                            .refresh();
                      },
                      contentPadding: EdgeInsets.zero,
                      trailing: Get.find<AppointmentController>()
                                  .AppointmentDataList[index]["time"] ==
                              Get.find<AppointmentController>().selectTime
                          ? CircleAvatar(
                              radius: 10,
                              backgroundColor: AppColors.mainColor,
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 12,
                              ),
                            )
                          : Text(""),
                      title: Text(
                        Get.find<AppointmentController>()
                            .AppointmentDataList[index]["time"]
                            .toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => Divider(
                    color: Colors.black,
                  ),
                );
              }),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
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
                  print(
                      'time => ${Get.find<AppointmentController>().selectTime}');
                  print(
                      'date => ${Get.find<AppointmentController>().selectData}');

                  if (Get.find<AppointmentController>().selectData == null ||
                      Get.find<AppointmentController>().selectData == '') {
                    AppDialogs.showToast(message: "برجاء اختيار التاريخ");
                    return;
                  }
                  if (Get.find<AppointmentController>().selectTime == null ||
                      Get.find<AppointmentController>().selectTime == '') {
                    AppDialogs.showToast(
                        message: "برجاء اختيار المعاد المناسب");
                    return;
                  }

                  controller.AppointmentDataList.value = [];

                  Get.find<AppointmentController>().selectNote = "";

                  if (Get.find<AppointmentController>()
                          .service["amount_to_pay"] ==
                      0) {
                    Get.to(() => AppointmentDataView());

                    return;
                  }

                  Get.toNamed(Routes.PAYMENT_APPOINTMENT);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customDateTimeLine({
    void Function(DateTime selectDate)? customOnTap,
  }) {
    return Obx(() {
      return Column(
        children: [
          Visibility(
            visible: selectDate!.value != null,
            child: Row(
              children: [
                Text("${getWeekdayInArabic(selectDate?.value ?? null)}"),
                Spacer(),
                Text(
                    "${selectDate?.value?.day}/${selectDate?.value?.month}/${selectDate?.value?.year}"),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                controller.getNonDates.value.length,
                (index) {
                  IsSelect = (selectDate == controller.getNonDates[index]).obs;

                  var dayNumber = controller.getNonDates[index].day;
                  var dayName =
                      getWeekdayInArabic(controller.getNonDates[index]);

                  bool notIncluded = !controller.fetchedDays.contains(dayName);

                  return InkWell(
                    overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    onTap: () {
                      if (notIncluded) return;
                      selectDate!.value = controller.getNonDates[index];
                      IsSelect.value = true;

                      customOnTap!(controller.getNonDates[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: IsSelect.value
                                  ? AppColors.mainColor
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "$dayNumber",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: notIncluded
                                      ? Colors.grey[400]
                                      : IsSelect.value
                                          ? Colors.white
                                          : Colors.black,
                                  fontFamily: "effra",
                                  decoration: notIncluded
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "$dayName",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color:
                                  notIncluded ? Colors.grey[400] : Colors.black,
                              decoration: notIncluded
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  ListTile doctorInfo({
    required String name,
    required String image,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: CashedNetworkImageView(
          imageUrl: image,
          boxFit: BoxFit.cover,
        ),
      ),
      title: Text(name),
    );
  }

  Widget itemBuilder(_, dayNumber, dayName, __, DateTime fullDate, isSelected) {
    bool contains = controller.getNonDates
        .contains(DateTime(fullDate.year, fullDate.month, fullDate.day));

    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: contains
                ? Colors.white
                : isSelected
                    ? AppColors.mainColor
                    : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: contains
                  ? Colors.grey[300]!
                  : isSelected
                      ? Colors.transparent
                      : Colors.grey,
            ),
          ),
          child: Center(
            child: Text(
              "$dayNumber",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: contains
                    ? Colors.grey[300]
                    : isSelected
                        ? Colors.white
                        : Colors.black,
                fontFamily: "effra",
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "$dayName",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: contains ? Colors.grey[300] : Colors.black,
          ),
        ),
      ],
    );
  }
}

String? getWeekdayInArabic(DateTime? date) {
  if (date == null) return '';
  DateFormat formatter =
      DateFormat('EEEE', 'ar'); // 'ar' is the locale for Arabic
  return formatter.format(date);
}
