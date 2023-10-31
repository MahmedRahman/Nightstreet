import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/commercial_brands/controllers/product_brand_controller.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/gift_card_builder_view.dart';
import 'package:krzv2/component/views/icon_button_component.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/shopping_cart_icon_view.dart';
import 'package:krzv2/models/product_brand_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class CommercialBrandsView extends GetView<ProductsBrandController> {
  CommercialBrandsView({
    Key? key,
    required this.initSelectedIds,
    required this.onChanged,
  }) : super(key: key);

  final List<int> initSelectedIds;
  final selectedIds = Rx<List<int>>([]);
  final ValueChanged<List<int>> onChanged;

  final authController = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    if (initSelectedIds.isNotEmpty) {
      selectedIds.value.addAll(initSelectedIds);
    }

    return BaseScaffold(
      appBar: CustomAppBar(
        titleText: 'الماركات التجارية',
        actions: [
          if (authController.isLoggedIn || authController.isGuestUser)
            ShoppingCartIconView(),
          AppSpacers.width20,
        ],
      ),
      body: Obx(
        () => themesListView(
          onSelected: (int value) {
            if (selectedIds.value.contains(value)) {
              selectedIds.value.remove(value);

              // onChanged(selectedIds.value);

              controller.update();
              return;
            }

            selectedIds.value.add(value);
            // onChanged(selectedIds.value);

            controller.update();
          },
          selectedIds: selectedIds.value,
        ),
      ),
      bottomBarHeight: 150,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: CustomBtnCompenent.main(
          text: 'تأكيد',
          onTap: () {
            onChanged(selectedIds.value);
            Get.back();
          },
        ),
      ),
    );
  }

  Widget themesListView({
    required ValueChanged<int> onSelected,
    required List<int> selectedIds,
  }) {
    final double itemHeight = (Get.height - kToolbarHeight - 24) / 2;
    final double itemWidth = Get.width / 2;
    return controller.obx(
      (List<ProuctBrandModel>? brands) {
        return GridView.builder(
          shrinkWrap: true,
          padding: AppDimension.appPadding + EdgeInsets.symmetric(vertical: 20),
          itemCount: brands?.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: (itemWidth / itemHeight) / .45,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (_, index) {
            final brand = brands?.elementAt(index);
            final isSelected = selectedIds.contains(brand!.id);
            return InkWell(
              onTap: () => onSelected.call(brand.id),
              overlayColor: MaterialStatePropertyAll(Colors.transparent),
              child: GiftCardBuilderView(
                isSelected: isSelected,
                image: brand.image,
              ),
            );
          },
        );
      },
    );
  }
}
