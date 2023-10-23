import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';

class DoctorCardView extends GetView {
  const DoctorCardView({
    Key? key,
    required this.doctorName,
    required this.doctorJob,
    required this.doctorImage,
    required this.onTap,
  }) : super(key: key);

  DoctorCardView.dummy({Function()? onTap})
      : doctorName = 'محمد بدر',
        doctorJob = 'أخصائي',
        doctorImage = "assets/image/dummy/avater.png",
        onTap = onTap ?? onTapped;

  static void onTapped() {
    Get.toNamed(Routes.ABOUT_DOCTOR);
  }

  final String doctorName;
  final String doctorJob;
  final String doctorImage;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 9),
        child: Text(
          '$doctorName',
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.right,
        ),
      ),
      subtitle: Text(
        '$doctorJob',
        style: TextStyle(
          fontSize: 14.0,
        ),
        textAlign: TextAlign.right,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 13,
        color: AppColors.blackColor,
      ),
      leading: Container(
        width: 90,
        child: Image.network(
          "$doctorImage",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
