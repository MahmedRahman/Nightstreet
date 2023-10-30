import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/commercial_brands/controllers/product_brand_controller.dart';
import 'package:krzv2/app/modules/commercial_brands/views/commercial_brands_view.dart';
import 'package:krzv2/models/product_brand_model.dart';

import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ProductBrandFieldView extends GetView<ProductsBrandController> {
  ProductBrandFieldView({
    Key? key,
    required this.initBandsIds,
    required this.onChanged,
  }) : super(key: key);

  final List<int> initBandsIds;
  final _selectedIds = Rx<List<int>>([]);
  final ValueChanged<List<int>> onChanged;
  @override
  Widget build(BuildContext context) {
    if (initBandsIds.isNotEmpty) {
      _selectedIds.value.addAll(initBandsIds);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الماركات التجارية',
          style: TextStyle(
            fontSize: 18.0,
            color: AppColors.blackColor,
            letterSpacing: 0.18,
            fontWeight: FontWeight.w500,
            height: 0.67,
          ),
          textAlign: TextAlign.right,
        ),
        AppSpacers.height16,
        GestureDetector(
            onTap: () => Get.to(
                  CommercialBrandsView(
                    initSelectedIds: _selectedIds.value,
                    onChanged: (List<int> ids) {
                      _selectedIds.value.clear();
                      _selectedIds.value.addAll(ids);
                      onChanged(ids);
                      controller.update();
                    },
                  ),
                ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.0),
                color: Colors.white,
                border: Border.all(
                  width: 1.0,
                  color: AppColors.greyColor,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'اختر من القائمة',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppColors.blackColor,
                      letterSpacing: 0.24,
                      height: 0.75,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ],
              ).paddingSymmetric(horizontal: 19),
            )),
        AppSpacers.height5,

        /// display selected brands
        controller.obx(
          (brands) {
            List<ProuctBrandModel> selectedList = brands!
                .where((item) => _selectedIds.value.contains(item.id))
                .toList();

            return Wrap(
              spacing: 2,
              children: selectedList
                  .map(
                    (brand) => Stack(
                      children: [
                        _brandNameBuilder(brand.name),
                        _removeIconBuider(
                          onTap: () {
                            _selectedIds.value.remove(brand.id);
                            onChanged(_selectedIds.value);

                            controller.update();
                          },
                        ),
                      ],
                    ),
                  )
                  .toList(),
            );
          },
        ),
        Divider(),
      ],
    );
  }

  Widget _removeIconBuider({required Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 18,
        width: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.mainColor,
        ),
        child: Icon(
          Icons.clear,
          size: 12,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _brandNameBuilder(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1.0,
          color: AppColors.greyColor,
        ),
      ),
      child: Text(title),
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 2.5,
      ),
      margin: const EdgeInsets.all(7),
    );
  }
}
