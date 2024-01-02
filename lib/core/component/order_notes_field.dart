import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/component/rounded_text_field.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OrderNotesField extends GetView {
  OrderNotesField({
    required this.onChanged,
  });
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset("images/svg/notes_icon.svg"),
              const SizedBox(width: 7),
              Text(
                'ملاحظات على الطلب',
                style: TextStyles.font12MediumBlack,
              )
            ],
          ),
          SizedBox(height: 15),
          RoundedTextField(
            labelText: "اكتب اي تفاصيل اضافية على الطلب …",
            backGroundColor: AppColor.KgrayColor3,
            borderColor: AppColor.KBorderColor,
            borderRadius: 8,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
