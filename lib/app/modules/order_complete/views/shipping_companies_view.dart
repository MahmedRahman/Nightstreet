import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/order_complete/controllers/shipping_companies_controller.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/shipping_method_card_view.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/models/shipping_companies_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class ShippingCompaniesView extends GetView<ShippingCompaniesController> {
  ShippingCompaniesView({
    required this.onChanged,
  });
  final ValueChanged<ShippingCompaniesModel> onChanged;
  final selectedCompany = Rx<ShippingCompaniesModel?>(null);

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(AppSvgAssets.shippingMethodIcon),
                AppSpacers.width10,
                Text(
                  'اختر شركة الشحن',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.blackColor,
                    letterSpacing: 0.16,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            AppSpacers.height12,
            Divider(),
            AppSpacers.height12,
            controller.obx(
              (List<ShippingCompaniesModel>? companies) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    final company = companies.elementAt(index);
                    final isSelected = company == selectedCompany.value;
                    return ShippingMethodCardView(
                      cost: company.cost.toString(),
                      name: company.name,
                      delivryTime: company.deliveryTime,
                      isSelected: isSelected,
                      onTap: () {
                        selectedCompany.value = company;
                        onChanged(company);
                        controller.update();
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  itemCount: companies!.length,
                );
              },
              onLoading: onLoading(),
              onError: (String? error) => Center(
                child: Text(
                  '${error.toString()}\nاختر عنوان اخر',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class onLoading extends StatelessWidget {
  const onLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return ShippingMethodCardView(
          cost: '40',
          name: 'شركة زاجل',
          delivryTime: '3',
          isSelected: false,
          onTap: () {},
        ).shimmer();
      },
      separatorBuilder: (_, __) => const Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Divider(),
      ),
      itemCount: 3,
    );
  }
}
