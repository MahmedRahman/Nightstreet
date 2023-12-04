import 'package:app_night_street/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.KOrangeColor,
      body: Center(
        child: SvgPicture.asset(
          "images/svg/app_logo.svg",
        ),
      ),
    );
  }
}
