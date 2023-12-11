import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/component/views/custom_back_button_component.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

class MyTestScreen extends GetView {
  MyTestScreen();

  final focusDate = Rx<DateTime?>(DateTime.now());
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          CustomBackButton(),
          const SizedBox(width: 20),
        ],
      ),
      body: Obx(
        () => Padding(
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
              doctorInfo(
                name: 'Mohammed Shams',
                image:
                    "https://cdn.vectorstock.com/i/preview-2x/44/06/doctor-icon-circle-vector-15604406.webp",
              ),
              AppSpacers.height25,
              EasyInfiniteDateTimeLine(
                controller: _controller,
                activeColor: const Color(0xffB04759),
                locale: "ar",
                onDateChange: (selectedDate) {
                  focusDate.value = selectedDate;
                },
                timeLineProps: EasyTimeLineProps(
                  hPadding: 0.0,
                  margin: EdgeInsets.zero,
                ),
                disabledDates: [DateTime.now()],
                focusDate: focusDate.value,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(
                  Duration(days: 365 * 2),
                ),
                itemBuilder: itemBuilder,
              ),
              Divider(),
              Expanded(
                child: ListView.separated(
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Text(
                          "${index + 1}:00 PM",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ),
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
      ),
    );
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

  Widget itemBuilder(_, dayNumber, dayName, __, ___, isSelected) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.mainColor : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey,
            ),
          ),
          child: Center(
            child: Text(
              "$dayNumber",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: isSelected ? Colors.white : Colors.black,
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
          ),
        ),
      ],
    );
  }
}
