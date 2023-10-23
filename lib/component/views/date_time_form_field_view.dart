import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class DateTimeFormFieldView extends GetView {
  DateTimeFormFieldView({
    Key? key,
    required this.onDateChanged,
    this.initialDateTime,
  }) {
    if (initialDateTime != '') {
      var parsedDate = DateTime.parse('$initialDateTime 00:00:00.000');
      selectedDate.value = parsedDate;
    }
  }

  final ValueChanged<DateTime> onDateChanged;
  final String? initialDateTime;

  final selectedDate = Rx<DateTime?>(null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تاريخ الميلاد',
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
        FormField<DateTime>(
          initialValue: selectedDate.value,
          onSaved: (DateTime? newValue) {
            onDateChanged(newValue!);
          },
          validator: (DateTime? val) {
            final isValid = (val ?? selectedDate.value) != null;

            if (!isValid) {
              return 'حقل مطلوب';
            }
            return null;
          },
          builder: (FormFieldState<DateTime> field) {
            return Obx(
              () {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                          confirmText: "تحديد",
                          cancelText: 'رجوع',
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: AppColors.mainColor,
                                  onPrimary: Colors.white,
                                  onSurface: AppColors.mainColor,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.mainColor,
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          selectedDate.value = pickedDate;
                          onDateChanged(pickedDate);
                        } else {
                          print("Date is not selected");
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 52.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xffF5F6FA),
                          border: Border.all(
                            color: field.hasError
                                ? Colors.red
                                : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset(AppSvgAssets.calendarIcon),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              selectedDate.value == null
                                  ? "تاريخ الميلاد"
                                  : '${selectedDate.value!.day} / ${selectedDate.value!.month} / ${selectedDate.value!.year}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: AppColors.greyColor,
                                letterSpacing: 0.48,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 6,
                        right: 20,
                      ),
                      child: Text(
                        field.errorText ?? '',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    )
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
