import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/update_phone/views/update_phone_view.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/component/views/date_time_form_field_view.dart';
import 'package:krzv2/component/views/profile_gender_selector_view.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final birthDateController = TextEditingController();
  final gendarController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final authService = Get.find<AuthenticationController>();

  @override
  void initState() {
    super.initState();
    final userData = authService.userData;
    nameController.text = userData?.name ?? '';
    phoneController.text = userData?.phone ?? '';
    emailController.text = userData?.email ?? '';
    birthDateController.text = userData?.birthDate ?? '';
    gendarController.text = userData?.gender ?? '';
    log('birth date => ${birthDateController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: 'تعديل الحساب',
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: AppDimension.appPadding,
          children: [
            AppSpacers.height25,
            TextFieldComponent.name(
              controller: nameController,
            ),
            AppSpacers.height29,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFieldComponent.phone(
                    controller: phoneController,
                    isReadOnly: true,
                  ),
                ),
                AppSpacers.width10,
                updatePhoneBtn()
              ],
            ),
            AppSpacers.height29,
            TextFieldComponent.email(
              controller: emailController,
              iconPath: AppSvgAssets.emailIcon,
              isRequired: false,
            ),
            AppSpacers.height29,
            DateTimeFormFieldView(
              initialDateTime: birthDateController.text,
              firstDate: DateTime(1900),
              lastDate: DateTime(DateTime.now().year - 18),
              onDateChanged: (DateTime value) {
                birthDateController.text = value.toString().substring(0, 10);
              },
            ),
            AppSpacers.height29,
            ProfileGenderSelectorView(
              initialValue: gendarController.text,
              onChanged: (ProfileGender gender) {
                gendarController.text = gender.name;
              },
            ),
            AppSpacers.height50,
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppDimension.appPadding,
        child: SizedBox(
          height: 150,
          child: Column(
            children: [
              CustomBtnCompenent.main(
                text: 'حفظ التعديلات',
                onTap: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  authService.updateProfile(
                    name: nameController.text,
                    email: emailController.text,
                    birthDate: birthDateController.text,
                    gender: gendarController.text,
                  );
                },
              ),
              AppSpacers.height25,
              InkWell(
                overlayColor: MaterialStatePropertyAll(Colors.transparent),
                onTap: () => AppDialogs.deleteAccountDialog(
                  onDelete: () => authService.deleteAccount(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppSvgAssets.trashIcon),
                    AppSpacers.width5,
                    Text(
                      'حذف الحساب',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.errorColor,
                        letterSpacing: 0.24,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell updatePhoneBtn() {
    return InkWell(
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      onTap: () {
        Get.bottomSheet(
          UpdatePhoneView(),
        );
      },
      child: Container(
        width: 52,
        height: 55,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(AppSvgAssets.updatePhoneIcon),
        ),
        decoration: BoxDecoration(
          color: AppColors.greyColor4,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
