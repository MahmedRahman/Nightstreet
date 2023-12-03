import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/auth_header_component.dart';
import 'package:krzv2/component/views/checkbox_component.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/custom_rich_text_component.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/component/views/profile_gender_selector_view.dart';
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
  final GlobalKey globalKey = GlobalKey();
  final phoneFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
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
                    onTap: onFieldTapped,
                    textInputAction: TextInputAction.next,
                  ),
                  AppSpacers.height19,
                  TextFieldComponent.phone(
                    controller: phoneController,
                    onTap: onFieldTapped,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).requestFocus(emailFocusNode),
                  ),
                 // AppSpacers.height19,
                  // TextFieldComponent.email(
                  //   controller: emailController,
                  //   focusNode: emailFocusNode,
                  //   isRequired: false,
                  //   onTap: onFieldTapped,
                  //   textInputAction: TextInputAction.done,
                  //   //isRequired: false,
                  // ),
                  AppSpacers.height12,

                  ProfileGenderSelectorView(
                    initialValue: '',
                    onChanged: (ProfileGender gender) {
                      //gendarController.text = gender.name;
                    },
                  ),
                  AppSpacers.height25,
                  CustomCheckBoxComponent(
                    onTaxtTapped: () => Get.toNamed(Routes.termsPage),
                    onChanged: (bool value) {
                      isTermsConfirmed.value = value;
                    },
                  ),
                  AppSpacers.height60,
                  CustomBtnCompenent.main(
                    key: globalKey,
                    text: "انشاء حساب",
                    onTap: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      if (isTermsConfirmed.value == false) {
                        AppDialogs.showToast(
                          message: "الرجاء الموافقة على كافة الشروط والأحكام",
                        );

                        return;
                      }

                      registerController.register(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        firebasToken: registerController.getFirebaseToken() ?? "",
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

  void onFieldTapped() async {
    await Future.delayed(Duration(milliseconds: 500));
    RenderObject? object = globalKey.currentContext!.findRenderObject();
    object!.showOnScreen(duration: Duration(milliseconds: 500));
  }
}
