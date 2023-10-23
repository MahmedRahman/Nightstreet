import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

showToast({required String message}) {
  return showTopSnackBar(
    Overlay.of(Get.context!),
    CustomSnackBar.error(
      message: message,
      backgroundColor: AppColors.mainColor,
    ),
  );
}
