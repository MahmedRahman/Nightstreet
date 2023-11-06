import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/custom_radio_view.dart';
import 'package:krzv2/component/views/custom_toggle_view.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

class OrderPaymentMethodsView extends GetView {
  OrderPaymentMethodsView({
    Key? key,
    required this.payWithCredit,
    required this.payWithWallet,
  }) : super(key: key);

  final RxBool _payWithCredit = false.obs;
  final ValueChanged<bool> payWithCredit;
  final ValueChanged<bool> payWithWallet;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthenticationController>();
    final walletIsGreaterThanZero =
        int.parse(authController.userData?.walletBalance ?? '0') != 0;
    return DecoratedContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(AppSvgAssets.blackWalletIcon),
                AppSpacers.width10,
                Text(
                  "اختر طريقة الدفع",
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(),
            ),
            if (walletIsGreaterThanZero) ...[
              Row(
                children: [
                  CustomToggleView(
                    activeColor: AppColors.mainColor,
                    deactivateColor: Colors.white,
                    Kselected: false,
                    onChanged: (bool vlu) {
                      payWithWallet(vlu);
                    },
                  ),
                  AppSpacers.width10,
                  Text(
                    'محفظة كرز',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.blackColor,
                      letterSpacing: 0.28,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'رصيدك الحالي : ${authController.userData?.walletBalance ?? ''}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: AppColors.greyColor,
                      letterSpacing: 0.18,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Divider(),
              ),
            ],
            Obx(
              () => InkWell(
                overlayColor: MaterialStatePropertyAll(Colors.transparent),
                onTap: () {
                  _payWithCredit.value = !_payWithCredit.value;
                  payWithCredit(_payWithCredit.value);
                },
                child: Row(
                  children: [
                    CustomRadioView(
                      isActive: _payWithCredit.value,
                    ),
                    AppSpacers.width10,
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
            ),
          ],
        ),
      ),
    );
  }
}
