import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/auth_header_component.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    //app_version.showUpdateDialog();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: AppDimension.appPadding,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  SvgPicture.asset(AppSvgAssets.logoIcon),
                  AppSpacers.height60,
                  const AuthHeader.login(),
                  AppSpacers.height60,
                  TextFieldComponent.phone(
                    controller: phoneController,
                  ),
                  AppSpacers.height60,
                  CustomBtnCompenent.main(
                    text: "تسجيل دخول",
                    onTap: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      await authenticationController.sendVerificationCode(
                        phoneNumber: phoneController.text,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomBtnCompenent.secondary(
                    text: "الدخول كزائز",
                    onTap: () async {
                      if (authenticationController.isLoggedIn) {
                        authenticationController.logout();
                      }
                      authenticationController.loginAsGuest(
                        firebaseToken: authenticationController
                            .getFirebaseToken()
                            .toString(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        // bottomNavigationBar: Container(
        //   color: Colors.white,
        //   padding: const EdgeInsets.only(
        //     top: 20,
        //     bottom: 10,
        //   ),
        //   child: CustomRichText(
        //     firstText: 'ليس لديك حساب!!',
        //     secondText: 'انشئ حسابك الان',
        //     onSecondTextTapped: () => Get.offAndToNamed(Routes.REGISTER),
        //   ),
        // ),
      ),
    );
  }
}
