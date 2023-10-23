import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/auth_header_component.dart';
import 'package:krzv2/component/views/checkbox_component.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_rich_text_component.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/component/views/toast_component.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  final isTermsConfirmed = false.obs;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController(text: Get.arguments as String);
  final emailController = TextEditingController();

  final registerController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
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
                  AppSpacers.height60,
                  const AuthHeader.register(),
                  AppSpacers.height60,
                  TextFieldComponent.name(
                    controller: nameController,
                  ),
                  AppSpacers.height19,
                  TextFieldComponent.phone(
                    controller: phoneController,
                  ),
                  AppSpacers.height19,
                  TextFieldComponent.email(
                    controller: emailController,
                    isRequired: false,
                    //isRequired: false,
                  ),
                  AppSpacers.height12,
                  CustomCheckBoxComponent(
                    onTaxtTapped: () => Get.toNamed(Routes.termsPage),
                    onChanged: (bool value) {
                      isTermsConfirmed.value = value;
                    },
                  ),
                  AppSpacers.height60,
                  CustomBtnCompenent.main(
                    text: "انشاء حساب",
                    onTap: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      if (isTermsConfirmed.value == false) {
                        showToast(
                          message: "الرجاء الموافقة على كافة الشروط والأحكام",
                        );

                        return;
                      }

                      registerController.register(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        firebasToken:
                            registerController.getFirebaseToken() ?? "",
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
            top: 20,
          ),
          child: CustomRichText(
            firstText: "لديك حساب بالفعل!!",
            secondText: "سجل دخول",
            onSecondTextTapped: () => Get.offAndToNamed(Routes.LOGIN),
          ),
        ),
      ),
    );
  }
}
