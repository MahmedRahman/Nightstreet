import 'package:app_night_street/core/component/cashed_network_image_view.dart';
import 'package:app_night_street/core/component/meal_counter.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CartItemBuilder extends GetView {
  const CartItemBuilder({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.onDeleteTapped,
    required this.onCounterChanged,
    super.key,
  });

  final String name;
  final String imageUrl;
  final String price;
  final Function()? onDeleteTapped;
  final Function(int)? onCounterChanged;

  CartItemBuilder.dummy()
      : imageUrl =
            "https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?q=80&w=2615&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        price = '100',
        name = 'مضاد التعرق كول راش من ديجري مين، يدوم لمدة 48 ساعة',
        onDeleteTapped = null,
        onCounterChanged = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 117,
      padding: EdgeInsets.all(13),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          CashedNetworkImageView(
            imageUrl: imageUrl,
            height: 89,
            width: 74,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: Get.width * .5),
                child: Text(
                  name,
                  style: TextStyles.font14mediumBlack,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                ),
              ),
              MealCounter(
                onCounterChanged: onCounterChanged ?? (_) {},
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: onDeleteTapped,
                overlayColor: MaterialStatePropertyAll(Colors.transparent),
                child: SvgPicture.asset("images/svg/delete_icon.svg"),
              ),
              Text(
                '$price جنيه',
                style: TextStyles.font12regularBlack,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
