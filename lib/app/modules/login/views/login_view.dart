import 'package:app_night_street/core/component/custom_text_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextBox(
                labelText: "رقم الهاتف",
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontFamily: 'Montserrat-Arabic',
                  fontSize: 14.0,
                  color: const Color(0xffE16D2C),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'مرحبا بعودتك!',
                style: TextStyle(
                  fontFamily: 'FF Shamel Family',
                  fontSize: 14.0,
                  color: const Color(0xFF2D2E49),
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
