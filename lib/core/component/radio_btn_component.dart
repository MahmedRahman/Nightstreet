import 'package:app_night_street/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RadioBtn extends GetView {
  const RadioBtn({
    super.key,
    required this.isSelected,
  });

  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: isSelected ? AppColor.KOrangeColor : Colors.transparent,
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(
          width: 1.0,
          color: isSelected ? Colors.transparent : Color(0xffD0D0D2),
        ),
      ),
      child: Icon(
        Icons.check,
        color: Colors.white,
        size: 15,
      ),
    );
  }
}
