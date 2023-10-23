import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_drop_menu_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class SubCategoriesDropmenuView extends GetView {
  const SubCategoriesDropmenuView({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final ValueChanged<int> onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'القسم الفرعي',
          style: TextStyle(
            fontSize: 18.0,
            color: AppColors.blackColor,
            letterSpacing: 0.18,
            fontWeight: FontWeight.w500,
            height: 0.67,
          ),
          textAlign: TextAlign.right,
        ),
        AppSpacers.height10,
        CustomDropMenuView<String>(
          requiredFiled: true,
          labelText: '',
          itemAsString: (String? u) => u!,
          items: ['قسم 1', 'قسم 2'],
          onChanged: (String? selectedTicket) {
            onChanged(1);
          },
          dropdownBuilder: (_, String? title) {
            return Text(
              title ?? 'القسم الفرعي',
              style: title == ''
                  ? null
                  : TextStyle(
                      fontSize: 16.0,
                      color: AppColors.greyColor,
                    ),
            );
          },
          popupItemBuilder: (_, String? title, __) {
            return Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: Text(
                title ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.greyColor,
                ),
              ),
            );
          },
        ),
        AppSpacers.height16,
        Divider(),
        AppSpacers.height16,
      ],
    );
  }
}
