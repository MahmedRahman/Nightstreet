import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Positioned(
          //   top: 0,
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     color: Colors.green,
          //     width: double.infinity,
          //     child: SvgPicture.asset(
          //       "images/svg/bg_layer_01.svg",
          //       color: Colors.red,
          //       fit: BoxFit.fitWidth,
          //     ),
          //   ),
          // ),
          // SvgPicture.asset(
          //   "images/svg/bg_layer_02.svg",
          // ),
        
        
        ],
      ),
    );
  }
}
