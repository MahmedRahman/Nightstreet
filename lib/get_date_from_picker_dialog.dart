import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

final _blackoutDates = <DateTime>[].obs;
Future<dynamic> getDateFromPickerDialog(
  BuildContext context, {
  DateTime? minDate,
  DateTime? maxDate,
  DateTime? initialDate,
  PickerDateRange? selectedRange,
  Function(DateTime start)? onDateSelected,
}) async {
  print('min $minDate');
  final initialDate0 =
      initialDate ?? DateTime.now().add(const Duration(days: 1));

  DateTime dateTime = initialDate0;
  final DateRangePickerController controller = DateRangePickerController();

  return await showDialog<dynamic>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    offset: const Offset(0, 3.0),
                    blurRadius: 50.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'تاريخ',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.blackColor,
                          letterSpacing: 0.32,
                          fontWeight: FontWeight.w500,
                          height: 0.75,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0xffFBFBFB),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Obx(
                  () => SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.single,
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      blackoutDates: _blackoutDates.value,
                    ),
                    monthCellStyle: DateRangePickerMonthCellStyle(
                      blackoutDateTextStyle: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    onViewChanged: (DateRangePickerViewChangedArgs args) =>
                        viewChanged(args, minDate),
                    controller: controller,
                    headerStyle: DateRangePickerHeaderStyle(
                      textStyle: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    initialDisplayDate: initialDate0,
                    initialSelectedDate: initialDate0,
                    minDate:
                        minDate ?? DateTime.now().add(const Duration(days: 1)),
                    maxDate: (maxDate ??
                        DateTime.now().add(const Duration(days: 300 * 2))),
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs
                        dateRangePickerSelectionChangedArgs) {
                      dateTime =
                          dateRangePickerSelectionChangedArgs.value as DateTime;

                      onDateSelected!(dateTime);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void viewChanged(DateRangePickerViewChangedArgs args, DateTime? minDate) {
  List<DateTime> _blackoutDateCollection = <DateTime>[];
  final DateTime visibleStartDate = args.visibleDateRange.startDate!;

  final diff = minDate!.difference(visibleStartDate).inDays;

  for (int i = 0; i < diff; i++) {
    _blackoutDateCollection.add(visibleStartDate.add(Duration(days: i)));
  }

  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    _blackoutDates.value = _blackoutDateCollection;
  });
}
