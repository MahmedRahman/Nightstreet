import 'package:app_night_street/core/component/app_logo.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/component/custom_text_form_field.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
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
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppLogo(),
              SizedBox(
                height: 32,
              ),
              Text(
                'تسجيل الدخول',
                style: TextStyles.font14BoldOrange,
              ),
              SizedBox(
                height: 13,
              ),
              Text(
                'مرحبا بعودتك!',
                style: TextStyles.font13mediumBlack,
              ),
              SizedBox(
                height: 23,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      labelText: "رقم الهاتف",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xffD8D8D8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text("+966"),
                          SizedBox(
                            width: 5,
                          ),
                          SvgPicture.asset("images/svg/soida.svg"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 23,
              ),
              CustomButton.fill(),
            ],
          ),
        ),
      ),
    );
  }
}
