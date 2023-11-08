import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/app/modules/wallet/components/coupon_form_component.dart';
import 'package:krzv2/app/modules/wallet/components/transaction_table_component.dart';
import 'package:krzv2/app/modules/wallet/components/user_balance_component.dart';
import 'package:krzv2/app/modules/wallet/controller/wallet_controller.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class WalletPage extends GetView<WalletController> {
  WalletPage({super.key});

  final authController = Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      onRefresh: () async => controller.onInit(),
      appBar: const CustomAppBar(
        titleText: "المحفظة",
      ),
      body: controller.obx(
        (transaction) {
          return ListView(
            padding: AppDimension.appPadding,
            children: [
              AppSpacers.height25,
              UserBalanceWidget(
                userBalance: '${authController.userData!.walletBalance}',
              ),
              _divider(),
              TransactionTableComponent(
                transactionsList: transaction!.transactions,
              ),
              _divider(),
              CouponForm(
                onTap: (String code) => controller.redeemWallet(
                  code: code,
                ),
              ),
              _divider(),
            ],
          );
        },
        onLoading: const Center(
          child: Center(
            child: SpinKitCircle(
              color: AppColors.mainColor,
              size: 70,
            ),
          ),
        ),
        onError: (error) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Padding _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(),
    );
  }
}
