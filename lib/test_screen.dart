import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:krzv2/utils/app_colors.dart';

class MyTestScreen extends StatelessWidget {
  const MyTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: EasyDateTimeLine(
                initialDate: DateTime.now(),
                onDateChange: (selectedDate) {
                  //`selectedDate` the new date selected.
                },
                headerProps: const EasyHeaderProps(
                  monthPickerType: MonthPickerType.switcher,
                  selectedDateFormat: SelectedDateFormat.fullDateDMonthAsStrY,
                ),
                dayProps: const EasyDayProps(
                  // You must specify the width in this case.
                  width: 124.0,
                ),
                disabledDates: [DateTime.now()],
                itemBuilder: (context, dayNumber, dayName, monthName, fullDate, isSelected) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.mainColor : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Text(
                            "$dayNumber",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
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
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
                activeColor: const Color(0xffB04759),
                locale: "ar",
              ),
            ),
            Divider(),
            Row(
              children: [
                Text("2:00"),
                Text("pm"),
              ],
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
    );
  }
}
