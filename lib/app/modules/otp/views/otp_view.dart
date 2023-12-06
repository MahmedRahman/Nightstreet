import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/component/app_logo.dart';
import 'package:app_night_street/core/component/custom_base_scaffold.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            AppLogo(),
            SizedBox(
              height: 60,
            ),
            Text(
              'تسجيل الدخول',
              style: TextStyles.font13mediumBlack,
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'أدخل كود التحقق المرسل الى 0512345678',
              style: TextStyles.font13boldBlack,
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: PinCodeTextField(
                length: 4,
                obscureText: false,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  activeFillColor: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 60,
                  fieldWidth: 50,

                  //activeFillColor: Colors.black,
                  inactiveColor: AppColor.KgrayColor,
                  inactiveFillColor: Colors.green,
                  selectedFillColor: Colors.deepPurple,
                  selectedColor: Colors.greenAccent,
                  activeColor: Colors.blue,
                ),
                animationType: AnimationType.fade,
                animationDuration: Duration(milliseconds: 300),
                onChanged: (value) {},
                appContext: Get.context!,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'أعد إرسال الرمز خلال 30 ثانية',
              style: TextStyles.font13mediumBlack,
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton.fill(
              title: "تحقق",
            )
          ],
        ),
      ),
    );
  }
}
