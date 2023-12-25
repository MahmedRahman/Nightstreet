import 'package:app_night_street/core/component/orange_bottom.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddToCartBtnAndPrice extends GetView {
  const AddToCartBtnAndPrice({
    super.key,
    required this.onAddToCardTapped,
    required this.price,
  });
  final String price;
  final Function() onAddToCardTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1a000000),
            offset: Offset(0, 10),
            blurRadius: 60,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: OrangeBtn(
                title: 'اضف الي العربة',
                iconPath: "images/svg/white_cart_icon.svg",
                onTap: onAddToCardTapped,
              ),
            ),
          ),
          Row(
            children: [
              SvgPicture.asset("images/svg/price_icon.svg"),
              const SizedBox(width: 6),
              Text(
                '$price جنيه',
                style: TextStyles.font16regularBlack2,
              ),
            ],
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
