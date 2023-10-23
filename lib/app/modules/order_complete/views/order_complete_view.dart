import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/custom_radio_view.dart';
import 'package:krzv2/component/views/custom_toggle_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/shipping_method_card_view.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/order_complete_controller.dart';

class OrderCompleteView extends GetView<OrderCompleteController> {
  OrderCompleteView({Key? key}) : super(key: key);
  final RxInt selectedShippintMethod = 100.obs;
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(titleText: 'اتمام الطلب'),
      body: ListView(
        padding: AppDimension.appPadding,
        children: [
          addressWidget(
            address:
                'الدمام - ضاحية الملك فهد - شارع الملك سعود بن عبد\nالعزيز',
            onEditAddressTapped: () {},
          ),
          AppSpacers.height10,
          addNewAddressBtn(
            onTap: () => Get.toNamed(Routes.DELIVERY_ADDRESSES),
          ),
          AppSpacers.height16,
          Divider(),
          AppSpacers.height16,
          DecoratedContainer(
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
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return Obx(
                        () => ShippingMethodCardView(
                          cost: '40',
                          name: 'شركة زاجل',
                          delivryTime: '3',
                          isSelected: selectedShippintMethod.value == index,
                          onTap: () => selectedShippintMethod.value = index,
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Divider(),
                    ),
                    itemCount: 3,
                  )
                ],
              ),
            ),
          ),
          AppSpacers.height16,
          DecoratedContainer(
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
                  Row(
                    children: [
                      CustomToggleView(
                        activeColor: AppColors.mainColor,
                        deactivateColor: Colors.white,
                        onChanged: (bool vlu) {},
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
                        'رصيدك الحالي : 120',
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
                  InkWell(
                    overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    onTap: () {},
                    child: Row(
                      children: [
                        CustomRadioView(
                          isActive: false,
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
                ],
              ),
            ),
          ),
          AppSpacers.height16,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(),
          ),
          DecoratedContainer(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AppSpacers.height16,
                  paymentSumaryItem(
                    title: "اجمالي المستحق لـ ( 4 منتج )",
                    value: "1760 رس",
                  ),
                  AppSpacers.height16,
                  paymentSumaryItem(
                    title: "مصاريف الشحــن",
                    value: "1760 رس",
                  ),
                  AppSpacers.height12,
                  DottedLine(
                    dashLength: 10,
                    dashGapLength: 5,
                    lineThickness: 3,
                    dashColor: AppColors.borderColor2,
                  ),
                  AppSpacers.height12,
                  paymentSumaryItem(
                    title: "الأجمالي المستحق للدفع",
                    value: "1000 رس",
                    textColor: AppColors.mainColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomBarHeight: 190,
      bottomNavigationBar: Padding(
        padding: AppDimension.appPadding,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'مجموع المنتجات (5)',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.blackColor,
                    letterSpacing: 0.16,
                    fontWeight: FontWeight.w500,
                    height: 2.19,
                  ),
                  textAlign: TextAlign.right,
                ),
                Spacer(),
                Text(
                  '1760 ر.س',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                    height: 1.19,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            AppSpacers.height12,
            CustomBtnCompenent.main(
              text: "تأكيد الطلب",
              onTap: () => AppDialogs.oderConfirmed(),
            ),
          ],
        ),
      ),
    );
  }

  Widget addNewAddressBtn({required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(AppSvgAssets.addIcon),
          AppSpacers.width5,
          Text(
            'عنوان جديد',
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.blackColor,
              height: 0.86,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget addressWidget({
    required String address,
    required Function() onEditAddressTapped,
  }) {
    return DecoratedContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'التوصيل إلى',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.blackColor,
                    height: 0.86,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                editAddressBtn(
                  onTap: onEditAddressTapped,
                ),
              ],
            ),
            AppSpacers.height16,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(AppSvgAssets.addressIcon),
                AppSpacers.width10,
                Text(
                  address,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.greyColor,
                    letterSpacing: 0.28,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget editAddressBtn({required Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: AppColors.borderColor2,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppSvgAssets.updatePhoneIcon,
              color: AppColors.blackColor,
              width: 15,
              height: 15,
            ),
            AppSpacers.width5,
            Text(
              'تعديل',
              style: TextStyle(
                fontSize: 12.0,
                color: AppColors.blackColor,
                letterSpacing: 0.24,
                height: 1.0,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }

  Row paymentSumaryItem({
    required String title,
    required String value,
    Color? textColor = Colors.black,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            color: textColor,
            height: 1.36,
          ),
          textAlign: TextAlign.right,
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.0,
            color: textColor,
            height: 1.36,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
