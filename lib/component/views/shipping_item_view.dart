import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/component/views/counter_view.dart';
import 'package:krzv2/component/views/price_with_discount_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class ShippingItemView extends GetView {
  ShippingItemView({
    Key? key,
    required this.image,
    required this.price,
    required this.name,
    required this.oldPrice,
    required this.amount,
    required this.onDeleteTapped,
    required this.onIncrement,
    required this.ondecrement,
  }) : super(key: key);

  final String image;
  final String name;
  final String price;
  final String oldPrice;
  final String amount;
  final void Function()? onDeleteTapped;
  final void Function()? onIncrement;
  final void Function()? ondecrement;

  ShippingItemView.demmy()
      : image =
            'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1646077574-screen-shot-2022-02-28-at-2-39-10-pm-1646077556.png?crop=1xw:0.9974358974358974xh;center,top&resize=980:*',
        price = '100',
        name = 'مضاد التعرق كول راش من ديجري مين، يدوم لمدة 48 ساعة',
        oldPrice = '120',
        amount = '2',
        ondecrement = null,
        onDeleteTapped = null,
        onIncrement = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 9),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.greyColor4.withOpacity(0.7),
        border: Border.all(
          width: 1.0,
          color: AppColors.borderColor2,
        ),
      ),
      child: Row(
        children: [
          AppSpacers.width10,
          CashedNetworkImageView(width: 94, height: 100, imageUrl: image),
          AppSpacers.width10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * .5,
                ),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: const Color(0xFF1F1F1F),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              AppSpacers.height5,
              PriceWithDiscountView(
                price: price,
                hasDiscount: oldPrice != '' ? true : false,
                oldPrice: oldPrice,
              ),
              AppSpacers.height5,
              Row(
                children: [
                  CounterView(
                    height: 30,
                    borderRadius: 6,
                    initValue: num.tryParse(amount.toString())!,
                    onDecrementTapped: ondecrement,
                    onIncrementTapped: onIncrement,
                  ),
                  AppSpacers.width10,
                  InkWell(
                    onTap: onDeleteTapped,
                    overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: AppColors.greyColor4,
                        border: Border.all(
                          width: 1.0,
                          color: AppColors.borderColor2,
                        ),
                      ),
                      child: SvgPicture.asset(
                        AppSvgAssets.deleteIcon,
                      ),
                    ),
                  ),
                ],
              ),
              //  AppSpacers.height10,
            ],
          ),
        ],
      ),
    );
  }

}
