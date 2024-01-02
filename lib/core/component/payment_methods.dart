import 'package:app_night_street/core/component/radio_btn_component.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PaymentMethods extends GetView {
  PaymentMethods({
    super.key,
    required this.onChanged,
  });

  final Function(String) onChanged;

  final RxString selectedPayment = ''.obs;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "طريقة االدفع",
          style: TextStyles.font14mediumBlack,
        ),
        const SizedBox(height: 17),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Obx(
            () => Column(
              children: [
                paymentMethod(
                  isSelected: selectedPayment.value == "apple_pay",
                  title: 'Apple Pay',
                  mainIcon: '',
                  extraIcons: ["images/svg/apple_pay.svg"],
                  onTap: () {
                    selectedPayment.value = "apple_pay";
                    onChanged(selectedPayment.value);
                  },
                ),
                SizedBox(height: 10),
                paymentMethod(
                  isSelected: selectedPayment.value == "visa",
                  title: 'البطاقة الائتمانية',
                  mainIcon: '',
                  extraIcons: [
                    "images/svg/mada.svg",
                    "images/svg/visa.svg",
                    "images/svg/master.svg",
                  ],
                  onTap: () {
                    selectedPayment.value = "visa";
                    onChanged(selectedPayment.value);
                  },
                ),
                SizedBox(height: 10),
                paymentMethod(
                  isSelected: selectedPayment.value == "cod",
                  title: 'دفع عند الاستلام',
                  mainIcon: '',
                  extraIcons: [
                    "images/svg/cod.svg",
                  ],
                  onTap: () {
                    selectedPayment.value = "cod";
                    onChanged(selectedPayment.value);
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class paymentMethod extends GetView {
  const paymentMethod({
    super.key,
    required this.title,
    required this.mainIcon,
    required this.extraIcons,
    required this.onTap,
    required this.isSelected,
  });

  final String title;
  final String mainIcon;
  final List<String> extraIcons;
  final Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Color(0xffE0A387).withOpacity(.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: onTap,
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RadioBtn(
              isSelected: isSelected,
            ),
            const SizedBox(width: 14),
            Text(
              title,
              style: TextStyles.font14mediumBlack,
            ),
            const Spacer(),
            ...extraIcons
                .map(
                  (icon) => Padding(
                    padding: const EdgeInsets.only(right: 9),
                    child: SvgPicture.asset(
                      icon,
                      width: 20,
                      height: 20,
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
