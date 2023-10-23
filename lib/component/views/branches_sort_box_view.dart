import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_radio_view.dart';
import 'package:krzv2/extensions/enums_extensions.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';

enum BranchSortEnum { nearest, topRated, non }

BranchSortEnum getBrancSortFromName(String name) {
  return BranchSortEnum.values.firstWhere(
    (gender) => gender.name == name,
    orElse: () => BranchSortEnum.non,
  );
}

class BranchesSortBoxView extends GetView {
  BranchesSortBoxView({
    Key? key,
    this.initialSelectedSort,
    required this.onSortSelected,
  }) {
    print('init => $initialSelectedSort');
    if (initialSelectedSort != null) {
      selectedSort.value = initialSelectedSort;
    }
  }

  final BranchSortEnum? initialSelectedSort;
  final ValueChanged<BranchSortEnum> onSortSelected;

  final selectedSort = Rx<BranchSortEnum?>(null);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: AppDimension.appPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'الترتيب',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.expand_more,
                color: AppColors.blackColor,
              ),
            ),
          ),
          Divider(),
          ...BranchSortEnum.values.map((sort) {
            if (sort == BranchSortEnum.non) return SizedBox();
            return Obx(
              () => ListTile(
                onTap: () {
                  selectedSort.value = sort;
                  onSortSelected(sort);
                },
                contentPadding: EdgeInsets.zero,
                title: Text(
                  sort.branchArabicText,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: CustomRadioView(
                  isActive: selectedSort.value == sort,
                ),
              ),
            );
          }),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
