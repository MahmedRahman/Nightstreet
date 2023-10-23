import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class GiftCardPaymentMethodsView extends GetView {
  final ValueChanged<String> onChanged;
  GiftCardPaymentMethodsView({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final selectedRadioValue = ''.obs;

  void handleRadioValueChanged(Object? value) {
    if (value != null) {
      selectedRadioValue.value = value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(AppSvgAssets.blackWalletIcon),
                    AppSpacers.width10,
                    Text(
                      'طريقة الدفع',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.blackColor,
                        letterSpacing: 0.16,
                        height: 0.75,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Divider(),
              ),
              InkWell(
                overlayColor: MaterialStatePropertyAll(Colors.transparent),
                onTap: () {
                  selectedRadioValue.value = 'البطاقات الإئتمانية';
                  onChanged(selectedRadioValue.value);
                },
                child: Row(
                  children: [
                    Radio(
                      value: 'البطاقات الإئتمانية',
                      groupValue: selectedRadioValue.value,
                      onChanged: null,
                      fillColor: MaterialStatePropertyAll(AppColors.mainColor),
                    ),
                    Text('البطاقات الإئتمانية'),
                    Spacer(),
                    Row(
                      children: [
                        SvgPicture.asset(AppSvgAssets.applePayIcon),
                        AppSpacers.width5,
                        SvgPicture.asset(AppSvgAssets.madaIcon),
                        AppSpacers.width5,
                        SvgPicture.asset(AppSvgAssets.visaIcon),
                        AppSpacers.width5,
                        SvgPicture.asset(AppSvgAssets.masterIcon),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
