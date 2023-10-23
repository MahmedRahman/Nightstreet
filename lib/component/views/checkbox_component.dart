import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class CustomCheckBoxComponent extends GetView {
  const CustomCheckBoxComponent({
    super.key,
    required this.onTaxtTapped,
    required this.onChanged,
  });

  final VoidCallback onTaxtTapped;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    RxBool isSelected = false.obs;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            isSelected.value = !isSelected.value;
            onChanged(isSelected.value);
          },
          child: Container(
            width: 22.0,
            height: 22.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: AppColors.greyColor2,
              border: Border.all(
                width: 1.0,
                color: AppColors.borderColor,
              ),
            ),
            child: Obx(
              () => Visibility(
                visible: isSelected.value,
                child: const Icon(
                  Icons.check,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
        AppSpacers.width5,
        InkWell(
          onTap: onTaxtTapped,
          child: const Text(
            'الموافقة على كافة الشروط والأحكام',
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.blackColor,
              decoration: TextDecoration.underline,
              height: 0.86,
            ),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}
