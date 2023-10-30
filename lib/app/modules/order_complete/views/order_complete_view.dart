import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/address/edit_address/views/edit_address_view.dart';
import 'package:krzv2/app/modules/address/list_addresses/controllers/delivery_addresses_controller.dart';
import 'package:krzv2/app/modules/order_complete/controllers/shipping_companies_controller.dart';
import 'package:krzv2/app/modules/order_complete/views/shipping_companies_view.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shoppint_cart_controller.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/order_complete_address_loading_view.dart';
import 'package:krzv2/component/views/order_payment_methods_view.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/models/shipping_companies_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/order_complete_controller.dart';

class OrderCompleteView extends GetView<OrderCompleteController> {
  OrderCompleteView({Key? key}) : super(key: key);

  final delivery = Get.put<DeliveryAddressesController>(
    DeliveryAddressesController(),
  );
  final cartController = Get.find<ShoppintCartController>();
  final selectedShippingCompany = Rx<ShippingCompaniesModel?>(null);
  final authController = Get.find<AuthenticationController>();
  RxBool payWithCredit = false.obs;
  RxBool payWithWallet = false.obs;
  RxString addressId = ''.obs;
  @override
  Widget build(BuildContext context) {
    final cartSummary = cartController.cartSummaryModel.value;
    return GetBuilder<DeliveryAddressesController>(
      builder: (controller) {
        final addresse = controller.addresses.value;
        final isEmpty = controller.addresses.value!.length == 0;
        final defaultAddress = Get.previousRoute == '/add-new-address'
            ? addresse?.last
            : addresse!
                .firstWhereOrNull((address) => address['is_default'] == 1);
        final shippingController = Get.put(ShippingCompaniesController());

        if (defaultAddress != null) {
          shippingController.getShppingCompanies(
            addressId: defaultAddress['id'].toString(),
          );
          addressId.value = defaultAddress['id'].toString();
        }

        if (controller.status.isLoading) {
          return OrderCompleteAddressLoadingView();
        }

        if (isEmpty) {
          return BaseScaffold(
            appBar: CustomAppBar(titleText: 'إتمام الطلب'),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppPageEmpty.addressesList(
                  description: 'لإستكمال الطلب يجب إضافة عنوان',
                ),
                AppSpacers.height25,
                addNewAddressBtn(
                  onTap: () => Get.toNamed(Routes.ADD_NEW_ADDRESS),
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          );
        }

        return BaseScaffold(
          appBar: CustomAppBar(titleText: 'إتمام الطلب'),
          body: ListView(
            padding: AppDimension.appPadding,
            children: [
              addressWidget(
                address:
                    '${defaultAddress['city']['name']} - ${defaultAddress['address']}',
                onEditAddressTapped: () {
                  Get.to(
                    () => editAddressView(
                      data: defaultAddress,
                    ),
                  );
                },
              ),
              AppSpacers.height10,
              addNewAddressBtn(
                onTap: () => Get.toNamed(
                  Routes.ADD_NEW_ADDRESS,
                  arguments: Get.currentRoute,
                ),
              ),
              AppSpacers.height16,
              Divider(),
              AppSpacers.height16,
              ShippingCompaniesView(
                onChanged: (ShippingCompaniesModel value) {
                  selectedShippingCompany.value = value;
                },
              ),
              AppSpacers.height16,
              OrderPaymentMethodsView(
                payWithCredit: (bool value) {
                  payWithCredit.value = value;
                },
                payWithWallet: (bool value) {
                  payWithWallet.value = value;
                },
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
                        title:
                            "اجمالي المستحق لـ ( ${cartSummary?.cartCount} منتج )",
                        value: "${cartSummary?.cartPrice} رس",
                      ),
                      AppSpacers.height16,
                      Obx(
                        () => paymentSumaryItem(
                          title: "مصاريف الشحــن",
                          value:
                              "${selectedShippingCompany.value?.cost ?? 0} رس",
                        ),
                      ),
                      AppSpacers.height16,
                      paymentSumaryItem(
                        title: "ضريبة القيمة المضافة (15%)",
                        value: "${cartSummary?.cartTax} رس",
                      ),
                      AppSpacers.height12,
                      DottedLine(
                        dashLength: 10,
                        dashGapLength: 5,
                        lineThickness: 3,
                        dashColor: AppColors.borderColor2,
                      ),
                      AppSpacers.height12,
                      Obx(
                        () => paymentSumaryItem(
                          title: "الأجمالي المستحق للدفع",
                          value:
                              "${(double.parse(cartSummary!.cartTotalPrice)) + (selectedShippingCompany.value?.cost ?? 0)}  رس",
                          textColor: AppColors.mainColor,
                        ),
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
                      'مجموع المنتجات (${cartSummary?.cartCount})',
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
                    Obx(
                      () => Text(
                        "${(double.parse(cartSummary!.cartTotalPrice)) + (selectedShippingCompany.value?.cost ?? 0)}  رس",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500,
                          height: 1.19,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                AppSpacers.height12,
                CustomBtnCompenent.main(
                  text: "تأكيد الطلب",
                  onTap: () {
                    print(
                        'selectedShippingCompany => ${selectedShippingCompany.value!.id}');
                    print('address => ${addressId.value}');

                    final controller = Get.find<OrderCompleteController>();
                    if (selectedShippingCompany.value == null) {
                      return AppDialogs.showToast(message: 'اختر شركة الشحن');
                    }

                    if (payWithCredit.value == false &&
                        payWithWallet.value == false) {
                      return AppDialogs.showToast(message: 'اختر طريقه الدفع');
                    }

                    if (payWithCredit.value == true &&
                        payWithWallet.value == false) {
                      print('pay with credit');
                      controller.requestOrder(
                        partnerId: selectedShippingCompany.value!.id.toString(),
                        addressId: addressId.value,
                        paymentMethod: "card",
                      );
                      return;
                    }

                    if (payWithWallet.value == true &&
                        payWithCredit.value == false) {
                      final walletBalance = double.tryParse(
                              authController.userData!.walletBalance) ??
                          0.0;

                      final amountToPay =
                          double.tryParse(cartSummary!.cartTotalPrice) ?? 0.0;

                      if (walletBalance < amountToPay) {
                        return AppDialogs.showToast(
                            message: 'ادفع الباقي عن طريق البطاقه الإئتمانية');
                      }

                      print('pay with wallet');
                      controller.requestOrder(
                        partnerId: selectedShippingCompany.value!.id.toString(),
                        addressId: addressId.value,
                        paymentMethod: "wallet",
                      );
                      return;
                    }

                    if (payWithCredit.value == true &&
                        payWithWallet.value == true) {
                      print('pay with wallet credit');
                      controller.requestOrder(
                        partnerId: selectedShippingCompany.value!.id.toString(),
                        addressId: addressId.value,
                        paymentMethod: "wallet_card",
                      );
                      return;
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget addNewAddressBtn({
    required Function() onTap,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.end,
  }) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
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
