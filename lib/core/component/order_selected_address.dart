import 'package:app_night_street/core/component/radio_btn_component.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedAddress extends StatelessWidget {
  const SelectedAddress({
    required this.title,
    required this.description,
  });
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 17,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          RadioBtn(
            isSelected: true,
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.font12regularGray2,
              ),
              const SizedBox(height: 3),
              Container(
                constraints: BoxConstraints(
                  maxWidth: Get.width * .6,
                ),
                child: Text(
                  description,
                  style: TextStyles.font14mediumBlack,
                  maxLines: 1,
                ),
              )
            ],
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
        ],
      ),
    );
  }
}
