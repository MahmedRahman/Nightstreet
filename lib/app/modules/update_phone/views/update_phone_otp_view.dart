import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/update_phone/controllers/update_phone_controller.dart';
import 'package:krzv2/app/modules/verify_phone/controllers/verify_phone_controller.dart';
import 'package:krzv2/component/views/auth_header_component.dart';
import 'package:krzv2/component/views/custom_back_button_component.dart';
import 'package:krzv2/component/views/custom_rich_text_component.dart';
import 'package:krzv2/component/views/pin_code_field_conponent.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:validator/validator.dart';

class UpdatePhoneOtpView extends GetView<UpdatePhoneController> {
  final formKey = GlobalKey<FormState>();

  final UpdatePhoneController updatePhoneController = Get.find();
  final verifyController = Get.put(VerifyPhoneController());

  final optController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // if (kDebugMode) {
    //   Get.find<UpdatePhoneController>().updatePhone(
    //     phoneNumber: Get.arguments.toString(),
    //     verificationCode: "7418",
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
                  onCompleted: (String value) async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    controller.updatePhone(
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
                  otpController: optController,
                ),
                AppSpacers.height60,
                Padding(
                  padding: AppDimension.appPadding,
                  child: Obx(
                    () => Visibility(
                      visible: verifyController.time.value == '00.00',
                      replacement: CustomRichText(
                        firstText: "سيتم إرسال الكود خلال :",
                        secondText: verifyController.time.value,
                        mainAxisAlignment: MainAxisAlignment.start,
                        onSecondTextTapped: () async {},
                      ),
                      child: CustomRichText(
                        firstText: "لم تتلق رسالة !",
                        secondText: "أعد إرسال الرمز",
                        mainAxisAlignment: MainAxisAlignment.start,
                        onSecondTextTapped: () {
                          verifyController.startTimer(30);
                          updatePhoneController.sendVerificationCode(
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
