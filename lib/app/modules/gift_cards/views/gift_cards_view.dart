import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/gift_cards/views/gift_card_payment_view.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/component/views/gift_card_builder_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:validator/validator.dart';

import '../controllers/gift_cards_controller.dart';

class GiftCardsView extends GetView<GiftCardsController> {
  final amountController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();
  var themeId = 0;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.getCouponsThemes();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          titleText: 'بطاقات الهدايا',
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: AppDimension.appPadding,
            children: [
              AppSpacers.height12,
              Text(
                'شراء بطاقة هدايا',
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.mainColor,
                  letterSpacing: 0.32,
                ),
              ),
              AppSpacers.height10,
              Divider(),
              Text(
                'اختيار ثيم',
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.blackColor,
                  letterSpacing: 0.32,
                ),
              ),
              AppSpacers.height10,
              Divider(),
              controller.obx(
                (data) {
                  return themesListView(
                    onSelected: (int selected) {
                      themeId = selected;
                    },
                    data: data,
                  );
                },
              ),
              Divider(),
              AppSpacers.height12,
              TextFieldComponent.number(
                controller: amountController,
              ),
              AppSpacers.height19,
              TextFieldComponent.name(
                controller: fullNameController,
              ),
              AppSpacers.height19,
              TextFieldComponent.phone(
                controller: phoneController,
              ),
              AppSpacers.height19,
              TextFieldComponent.longMessage(
                outLineText: 'أرسل رسالة',
                hintText: 'أدخل الرسالة',
                controller: messageController,
                validator: customValidator(
                  rules: [
                    IsRequired(message: 'حقل مطلوب'),
                    IsBetween(min: 3, max: 30),
                  ],
                ),
              ),
              AppSpacers.height50,
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 30,
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomBtnCompenent.secondary(
                  text: "الغاء",
                  onTap: () => Get.back(),
                ),
              ),
              AppSpacers.width10,
              Expanded(
                flex: 3,
                child: CustomBtnCompenent.main(
                  text: 'مواصلة عملية الشراء',
                  onTap: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    if (themeId == 0) {
                      AppDialogs.showToast(message: "برجاء اختيار الثيم");
                      return;
                    }

                    Get.to(
                      GiftCardPaymentView(
                        amount: amountController.text.toString(),
                        fullName: fullNameController.text.toString(),
                        message: messageController.text.toString(),
                        // paymentType: "",
                        phone: phoneController.text.toString(),
                        themeId: themeId.toString(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GridView themesListView({
    required ValueChanged<int> onSelected,
    required List data,
  }) {
    final double itemHeight = (Get.height - kToolbarHeight - 24) / 2;
    final double itemWidth = Get.width / 2;
    RxInt selectValue = 0.obs;
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: (itemWidth / itemHeight) / .50,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        //final isSelected = controller.selectedIndex.value == index;

        return Obx(() {
          return InkWell(
            onTap: () {
              selectValue.value = data[index]["id"];
              onSelected.call(data[index]["id"]);
            },
            overlayColor: MaterialStatePropertyAll(Colors.transparent),
            child: GiftCardBuilderView(
              isSelected: !(selectValue.value == data[index]["id"]),
              image: data[index]["image"],
            ),
          );
        });
      },
    );
  }
}
