import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ServiceInformationView extends GetView {
  const ServiceInformationView({
    Key? key,
    required this.doctorName,
    required this.serviceName,
    this.clinicAddress = '',
    this.clinicName = '',
  }) : super(key: key);

  final String serviceName;
  final String doctorName;
  final String? clinicName;
  final String? clinicAddress;
  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 17,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الخدمة المختارة',
              style: TextStyle(
                fontSize: 16.0,
                color: AppColors.mainColor,
                letterSpacing: 0.32,
                fontWeight: FontWeight.w500,
                height: 0.75,
              ),
              textAlign: TextAlign.right,
            ),
            AppSpacers.height10,
            Text(
              serviceName,
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.blackColor,
                letterSpacing: 0.42,
                height: 1.79,
              ),
              textAlign: TextAlign.right,
            ),
            if (clinicAddress != '' && clinicName != '')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clinicName!,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.blackColor,
                        height: 1.36,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    AppSpacers.width10,
                    Html(
                      data: clinicAddress ?? '',
                    ),
                    // Text(
                    //   clinicAddress!,
                    //   style: TextStyle(
                    //     fontSize: 13.0,
                    //     color: AppColors.greyColor,
                    //     height: 1.46,
                    //   ),
                    //   textAlign: TextAlign.right,
                    // ),
                  ],
                ),
              )
            else
              SizedBox(),
            doctorName == ""
                ? SizedBox.shrink()
                : Text(
                    'اسم الطبيب : $doctorName',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppColors.blackColor,
                      letterSpacing: 0.32,
                      height: 1.56,
                    ),
                    textAlign: TextAlign.right,
                  ),
          ],
        ),
      ),
    );
  }
}
