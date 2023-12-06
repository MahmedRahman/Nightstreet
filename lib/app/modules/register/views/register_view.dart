import 'package:app_night_street/core/component/custom_base_scaffold.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/component/custom_text_form_field.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "اكمل التسجيل",
          style: TextStyles.font14mediumBlack,
        ),
      ),
      body: Column(
        children: [
          CustomTextFormField(
            labelText: "الأسم كاملا",
            IconWidget: SvgPicture.asset("images/svg/user.svg"),
          ),
          SizedBox(
            height: 25,
          ),
          CustomTextFormField(
            labelText: "رقم الهاتف",
            IconWidget: SvgPicture.asset("images/svg/phone.svg"),
          ),
          SizedBox(
            height: 25,
          ),
          CustomTextFormField(
            labelText: "البريد الالكتروني",
            IconWidget: SvgPicture.asset("images/svg/email.svg"),
          ),
          SizedBox(
            height: 25,
          ),
          CustomButton.fill(
            title: "التسجيل",
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
