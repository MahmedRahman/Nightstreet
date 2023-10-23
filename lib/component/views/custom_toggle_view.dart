import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';

class CustomToggleView extends GetView {
  CustomToggleView({
    Key? key,
    required this.activeColor,
    required this.deactivateColor,
    required this.onChanged,
  }) : super(key: key);

  final Color activeColor;
  final Color deactivateColor;
  final Function(bool) onChanged;

  final RxBool selected = false.obs;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selected.value = !selected.value;
        onChanged(selected.value);
      },
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.bounceIn,
          width: 35,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: AppColors.greyColor,
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            alignment:
                selected.value ? Alignment.centerRight : Alignment.centerLeft,
            curve: Curves.fastOutSlowIn,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: selected.value ? activeColor : deactivateColor,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
