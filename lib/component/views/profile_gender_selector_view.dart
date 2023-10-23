import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/extensions/enums_extensions.dart';

import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

enum ProfileGender { male, female }

ProfileGender getGenderFromName(String name) {
  return ProfileGender.values.firstWhere(
    (gender) => gender.name == name,
  );
}

class ProfileGenderSelectorView extends GetView {
  ProfileGenderSelectorView({
    Key? key,
    required this.onChanged,
    this.initialValue = '',
  }) {
    if (initialValue != '') {
      selectedGender.value = getGenderFromName(initialValue ?? '');
    }
  }

  final selectedGender = Rx<ProfileGender?>(null);
  final String? initialValue;
  final Function(ProfileGender gender) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "اختر الجنس",
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
        FormField<ProfileGender>(
          onSaved: (ProfileGender? newValue) {
            onChanged(newValue!);
          },
          validator: (ProfileGender? val) {
            final isValid = (val ?? selectedGender.value) != null;

            if (!isValid) {
              return 'حقل مطلوب';
            }
            return null;
          },
          builder: (FormFieldState<ProfileGender> field) => Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: ProfileGender.values
                      .map(
                        (gender) => genderCart(
                          name: gender.profileArabicText,
                          hasError: field.hasError,
                          isSelected: gender == selectedGender.value,
                          onTap: () {
                            selectedGender.value = gender;
                            onChanged(gender);
                          },
                        ),
                      )
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 6,
                    right: 20,
                  ),
                  child: Text(
                    field.errorText ?? '',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget genderCart({
    required String name,
    required isSelected,
    required Function()? onTap,
    bool? hasError = false,
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
            color: hasError ?? false
                ? Colors.red
                : isSelected
                    ? AppColors.borderColor2
                    : Colors.transparent,
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
