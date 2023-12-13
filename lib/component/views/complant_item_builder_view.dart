import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:krzv2/component/views/complant_status_view.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/utils/app_colors.dart';

class ComplantItemBuilderView extends GetView {
  const ComplantItemBuilderView({
    Key? key,
    required this.complaintDate,
    required this.complaintId,
    required this.statusTitle,
    required this.isActiveComplaint,
    required this.mainCategory,
    required this.onTap,
  }) : super(key: key);

  final String complaintId;
  final String statusTitle;
  final String mainCategory;

  final DateTime complaintDate;
  final bool isActiveComplaint;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    complaintId,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.blackColor,
                      letterSpacing: 0.42,
                      height: 1.57,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'القسم الرئيسي : $mainCategory',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.blackColor,
                      letterSpacing: 0.42,
                      height: 1.57,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    formatDateToArabic(complaintDate),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.greyColor,
                      letterSpacing: 0.14,
                      height: 2.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Spacer(),
              ComplantStatusView(
                isActiveComplaint: isActiveComplaint,
                statusTitle: statusTitle,
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatDateToArabic(DateTime dateTime) {
    final arabicDateFormatter = DateFormat('EEEE، dd MMMM yم', 'ar');
    String formattedDate = arabicDateFormatter.format(dateTime);
    return formattedDate;
  }
}
