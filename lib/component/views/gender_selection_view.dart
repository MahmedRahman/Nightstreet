import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/extensions/enums_extensions.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

enum Gender { male, female, both }

class GenderSelectionView extends GetView {
  GenderSelectionView({
    Key? key,
    required this.onChanged,
    required this.initValue,
  }) {
    if (initValue != '') {
      final gender = Gender.values.firstWhere((e) => e.name == initValue);
      selectedGender.value = gender.arabicText;
    }
  }

  final selectedGender = ''.obs;
  final String initValue;
  final Function(String gender) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        AppSpacers.height16,
        Text(
          'اختر الفئة',
          style: TextStyle(
            fontSize: 18.0,
            color: AppColors.blackColor,
            letterSpacing: 0.18,
            fontWeight: FontWeight.w500,
            height: 0.67,
          ),
          textAlign: TextAlign.right,
        ),
        AppSpacers.height12,
        Obx(
          () => Row(
            children: Gender.values
                .map(
                  (e) => genderCart(
                    name: e.arabicText,
                    isSelected: e.arabicText == selectedGender.value,
                    onTap: () {
                      selectedGender.value = e.arabicText;
                      onChanged(e.name);
                    },
                  ),
                )
                .toList(),
          ),
        ),
        AppSpacers.height16,
        Divider(),
      ],
    );
  }

  Widget genderCart({
    required String name,
    required isSelected,
    required Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: Container(
        width: 90.0,
        height: 40.0,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: isSelected ? AppColors.mainColor : AppColors.greyColor4,
          border: Border.all(
            width: 1.0,
            color: isSelected ? AppColors.borderColor2 : Colors.transparent,
          ),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 16.0,
              color: isSelected ? Colors.white : AppColors.blackColor,
              letterSpacing: 0.24,
              height: 0.75,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
