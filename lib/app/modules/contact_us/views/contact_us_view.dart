import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/custom_app_bar.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/component/rounded_text_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: CustomAppBar(titleText: "تواصل معنا"),
      child: ListView(
        padding: AppDimension.appPadding.copyWith(top: 40),
        children: [
          RoundedTextField(
            labelText: "الاسم",
            maxLines: 1,
            onChanged: (String text) {},
          ),
          const SizedBox(height: 16),
          RoundedTextField(
            labelText: "عنوان الاساسية",
            maxLines: 1,
            onChanged: (String text) {},
          ),
          const SizedBox(height: 16),
          RoundedTextField(
            labelText: "الوصف",
            borderRadius: 16,
            maxLines: 8,
            onChanged: (String text) {},
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppDimension.appPadding.copyWith(
          bottom: 40,
        ),
        child: CustomButton.fill(
          onPressed: () {},
          title: "ارسال",
          borderRadius: 32,
        ),
      ),
    );
  }
}
