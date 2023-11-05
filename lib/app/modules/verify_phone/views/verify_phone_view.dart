import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/auth_header_component.dart';
import 'package:krzv2/component/views/custom_back_button_component.dart';
import 'package:krzv2/component/views/custom_rich_text_component.dart';
import 'package:krzv2/component/views/pin_code_field_conponent.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:validator/validator.dart';

import '../controllers/verify_phone_controller.dart';

class VerifyPhoneView extends GetView<VerifyPhoneController> {
  final formKey = GlobalKey<FormState>();

  final AuthenticationController authenticationController = Get.find();

  final optController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // if (kDebugMode) {
    //   Get.find<AuthenticationController>().loginWithPhoneNumber(
    //     phoneNumber: Get.arguments.toString(),
    //     verificationCode: "741",
    //   );
    // }

    return Scaffold(
      body: ListView(
        padding: AppDimension.appPadding,
        children: [
          AppSpacers.height60,
          const CustomBackButton(),
          AppSpacers.height50,
          Form(
            key: formKey,
            child: Column(
              children: [
                AuthHeader.verifyCode(
                  customerPhone: Get.arguments.toString(),
                ),
                AppSpacers.height60,
                PinCodeField(
                  otpController: optController,
                  onCompleted: (String value) async {
                    FocusManager.instance.primaryFocus?.unfocus();

                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    Get.find<AuthenticationController>().loginWithPhoneNumber(
                      phoneNumber: Get.arguments.toString(),
                      verificationCode: value,
                      onError: () {
                        optController.clear();
                      },
                    );
                  },
                  validator: customValidator(
                    rules: [
                      IsRequired(message: 'رمز خاطئ ، يرجى المحاولة مرة أخرى'),
                      IsOTP(message: 'رمز خاطئ ، يرجى المحاولة مرة أخرى'),
                    ],
                  ),
                ),
                AppSpacers.height60,
                Padding(
                  padding: AppDimension.appPadding,
                  child: Obx(
                    () => Visibility(
                      visible: controller.time.value == '00.00',
                      replacement: CustomRichText(
                        firstText: "سيتم إرسال الكود خلال :",
                        secondText: controller.time.value,
                        mainAxisAlignment: MainAxisAlignment.start,
                        onSecondTextTapped: () async {
                          // await Get.find<AuthenticationService>().;
                        },
                      ),
                      child: CustomRichText(
                        firstText: "لم تتلق رسالة !",
                        secondText: "أعد إرسال الرمز",
                        mainAxisAlignment: MainAxisAlignment.start,
                        onSecondTextTapped: () {
                          controller.startTimer(30);
                          authenticationController.reSendVerificationCode(
                            phoneNumber: Get.arguments.toString(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
