import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/models/complaint_category_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ComplaintCategorySelectorView extends GetView {
  ComplaintCategorySelectorView({
    Key? key,
    required this.categoriesList,
    required this.onChanged,
  }) : super(key: key);

  final selectedIndex = Rx<int>(0);
  final List<ComplaintCategoryModel> categoriesList;
  final ValueChanged<ComplaintCategoryModel> onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'حدد نوع التذكرة',
          style: const TextStyle(
            fontSize: 16.0,
            color: AppColors.blackColor,
            letterSpacing: 0.32,
            fontWeight: FontWeight.w500,
            height: 0.75,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => InkWell(
            onTap: () {
              _showDialog(
                CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32,
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedIndex.value,
                  ),
                  children: List<Widget>.generate(
                    categoriesList.length,
                    (int index) {
                      return Center(child: Text(categoriesList[index].name));
                    },
                  ),
                  onSelectedItemChanged: (int selectedItemIndex) {
                    selectedIndex.value = selectedItemIndex;
                    onChanged(categoriesList[selectedItemIndex]);
                  },
                ),
              );
            },
            child: Container(
              height: 52.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.greyColor2,
              ),
              child: Row(
                children: [
                  AppSpacers.width20,
                  Text(
                    categoriesList[selectedIndex.value].name,
                    style: TextStyle(
                      fontFamily: 'Effra',
                      fontSize: 16.0,
                      color: AppColors.greyColor,
                      letterSpacing: 0.32,
                      height: 0.75,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: Get.context!,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
