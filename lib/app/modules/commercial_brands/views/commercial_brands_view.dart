import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/gift_card_builder_view.dart';
import 'package:krzv2/component/views/icon_button_component.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/commercial_brands_controller.dart';

class CommercialBrandsView extends GetView<CommercialBrandsController> {
  const CommercialBrandsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: 'الماركات التجارية',
        actions: [
          CustomIconButton(
            onTap: () => Get.toNamed(Routes.SHOPPINT_CART),
            iconPath: AppSvgAssets.cartIcon,
            count: 2,
          ),
          AppSpacers.width20,
        ],
      ),
      body: Obx(
        () => themesListView(
          onSelected: (int value) {
            if (controller.selectedBrandIds.contains(value)) {
              controller.selectedBrandIds.remove(value);

              return;
            }
            controller.selectedBrandIds.add(value);
          },
          selectedIds: controller.selectedBrandIds.value,
        ),
      ),
    );
  }

  GridView themesListView({
    required ValueChanged<int> onSelected,
    required List<int> selectedIds,
  }) {
    final double itemHeight = (Get.height - kToolbarHeight - 24) / 2;
    final double itemWidth = Get.width / 2;
    return GridView.builder(
      shrinkWrap: true,
      padding: AppDimension.appPadding + EdgeInsets.symmetric(vertical: 20),
      itemCount: 20,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: (itemWidth / itemHeight) / .45,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final isSelected = selectedIds.contains(index);
        return InkWell(
          onTap: () => onSelected.call(index),
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
          child: GiftCardBuilderView(
            isSelected: isSelected,
            image:
                'https://www.edigitalagency.com.au/wp-content/uploads/nike-logo-png-black-icon-white-background-large.png',
          ),
        );
      },
    );
  }
}
