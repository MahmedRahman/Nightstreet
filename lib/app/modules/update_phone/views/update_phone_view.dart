import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/update_phone/controllers/update_phone_controller.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

class UpdatePhoneView extends GetView<UpdatePhoneController> {
  UpdatePhoneView({
    Key? key,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final controller = Get.put(UpdatePhoneController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      color: Colors.white,
      child: Padding(
        padding: AppDimension.appPadding,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              AppSpacers.height10,
              header(),
              Divider(),
              AppSpacers.height29,
              TextFieldComponent.phone(
                controller: phoneController,
              ),
              AppSpacers.height40,
              CustomBtnCompenent.main(
                text: 'تأكيد',
                onTap: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  controller.sendVerificationCode(
                    phoneNumber: phoneController.text,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'تعديل رقم الجوال',
          style: TextStyle(
            fontSize: 16.0,
            color: AppColors.blackColor,
            letterSpacing: 0.48,
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
          onTap: () => Get.back(),
          child: Container(
            width: 24.0,
            height: 24.0,
            child: Center(
              child: Icon(
                Icons.clear,
                color: AppColors.greyColor,
                size: 17,
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.borderColor2,
            ),
          ),
        ),
      ],
    );
  }
}
