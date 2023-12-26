import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OrangeBtn extends GetView {
  final String title;
  final Function() onTap;
  final String? iconPath;

  OrangeBtn({
    required this.title,
    required this.onTap,
    this.iconPath,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: const Color(0xfff26404),
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0d000000),
              offset: Offset(0, 10),
              blurRadius: 60,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: iconPath != '',
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SvgPicture.asset(iconPath ?? ''),
              ),
            ),
            Text(
              title,
              style: TextStyles.font16regularwhite,
              textAlign: TextAlign.center,
              softWrap: false,
            ),
          ],
        ),
      ),
    );
  }
}
