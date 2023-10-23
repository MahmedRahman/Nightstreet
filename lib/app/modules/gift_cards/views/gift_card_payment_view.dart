import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/gift_cards/controllers/gift_cards_controller.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/gift_card_payment_methods_view.dart';
import 'package:krzv2/component/views/gift_card_payment_summary_view.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

class GiftCardPaymentView extends GetView {
  GiftCardsController controller = Get.put(GiftCardsController());

  final String message;
  final String amount;
  var paymentType = "";
  final String fullName;
  final String phone;
  final String themeId;

  GiftCardPaymentView({
    required this.message,
    required this.amount,
    // required this.paymentType,
    required this.fullName,
    required this.phone,
    required this.themeId,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'دفع قيمة الطلب',
      ),
      body: ListView(
        padding: AppDimension.appPadding,
        children: [
          AppSpacers.height12,
          GiftCardPaymentSummaryView(
            giftCost: '${amount.toString()}',
            totalCost: '${amount.toString()}',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(),
          ),
          GiftCardPaymentMethodsView(
            onChanged: (String selectedPaymentMethod) {
              paymentType = "card";
              // print(selectedPaymentMethod.toString());
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 30,
        ),
        child: CustomBtnCompenent.main(
          text: 'تأكيد الطلب',
          onTap: () {
            if (paymentType == "") {
              AppDialogs.showToast(message: "برجاء اختيار طرق الدفع");
              return;
            }
            controller.setCoupons(
              message: message,
              amount: amount,
              paymentType: paymentType,
              fullName: fullName,
              phone: phone,
              themeId: themeId,
            );
            
          },
        ),
      ),
    );
  }
}
