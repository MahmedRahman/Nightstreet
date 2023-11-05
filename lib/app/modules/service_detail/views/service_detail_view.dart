import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/appointment/appointment_address_controller.dart';
import 'package:krzv2/app/modules/appointment/views/appointment_address_view.dart';
import 'package:krzv2/app/modules/favorite/controllers/offer_favorite_controller.dart';
import 'package:krzv2/app/modules/service_detail/views/doctor_list_view.dart';
import 'package:krzv2/app/modules/service_detail/views/review_Information_view.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/favorite_icon_view.dart';
import 'package:krzv2/component/views/icon_button_component.dart';
import 'package:krzv2/component/views/image_swpier_view.dart';
import 'package:krzv2/component/views/on_offer_loading.dart';
import 'package:krzv2/component/views/price_with_discount_view.dart';
import 'package:krzv2/component/views/product_cash_back_view.dart';
import 'package:krzv2/component/views/rating_bar_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/component/views/share_icon_view.dart';
import 'package:krzv2/component/views/tabs/base_switch_3_tap.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/service_detail_controller.dart';

class ServiceDetailView extends GetView<ServiceDetailController> {
  final controller = Get.put(ServiceDetailController());
  RxString favId = ''.obs;
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(
        onBackTapped: () => Get.back(result: favId.value),
        titleText: "تفاصيل الخدمة",
        actions: [
          CustomIconButton(
            onTap: () {},
            iconPath: AppSvgAssets.notificationIcon,
            count: 0,
          ),
          AppSpacers.width20,
        ],
      ),
      body: controller.obx(
        (data) {
          return Scaffold(
              // backgroundColor: Colors.transparent,
              bottomSheet: Container(
                // color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 5,
                    bottom: 5,
                  ),
                  child: CustomBtnCompenent.main(
                    text: 'احجز موعد الآن',
                    onTap: () {
                      if (Get.put(AuthenticationController().isLoggedIn) == false) {
                        return AppDialogs.showToast(message: 'الرجاء تسجيل الدخول');
                      }
                      if (data["branches"].length == 0) {
                        AppDialogs.showToast(message: "لا يوجد فروع");
                      }

                      Get.find<AppointmentController>().service = data;
                      Get.find<AppointmentController>().selectBranch = data["branches"][0];

                      Get.to(
                        AppointmentAddressView(),
                      );
                    },
                  ),
                ),
              ),
              body: Padding(
                padding: AppDimension.appPadding,
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacers.height12,
                    ImageSwpierView(
                      images: List.generate(
                        data["images"].length,
                        (index) {
                          return data["images"][index]["image"];
                        },
                      ),
                    ),
                    AppSpacers.height10,
                    clinicInformationBox(
                      isFavorite: data['is_favorite'],
                      title: data["clinic"]["name"],
                      onFavoriteTap: () {
                        if (Get.put(AuthenticationController().isLoggedIn) == false) {
                          return AppDialogs.showToast(message: 'الرجاء تسجيل الدخول');
                        }
                        final favCon = Get.put<OfferFavoriteController>(
                          OfferFavoriteController(),
                        );

                        data['is_favorite'] = !data['is_favorite'];
                        favId.value = data['id'].toString();

                        favCon.addRemoveOfferFromFavorite(
                          offerId: data['id'],
                          onError: () {
                            data['is_favorite'] = !data['is_favorite'];
                            favId.value = '';
                          },
                        );
                        controller.update();
                      },
                      onUploadTap: () {
                        Share.share(
                          'https://krz.sa/',
                          subject: data["name"],
                        );
                      },
                    ),
                    Divider(),
                    Text(
                      data["name"],
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 2.19,
                      ),
                    ),
                    AppSpacers.height10,
                    ReviewInformationBox(
                      price: data["price"].toString(),
                      oldPrice: data["old_price"].toString(),
                      totalRateAvg: data["total_rate_avg"].toString(),
                      totalRateCount: data["total_rate_count"].toString(),
                    ),
                    AppSpacers.height10,
                    Text(
                      'ادفع ${data["amount_to_pay"].toString()} الآن والباقي في العيادة',
                      style: TextStyle(
                        //fontFamily: 'Effra',
                        fontSize: 16.0,
                        color: AppColors.mainColor,
                        letterSpacing: 0.16,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        height: 2.19,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    AppSpacers.height10,
                    Divider(),
                    AppSpacers.height10,
                    data["cashback"].toString() == "0"
                        ? SizedBox.shrink()
                        : ProductCashBackView(
                            cashBackValue: data["cashback"].toString(),
                          ),
                    AppSpacers.height10,
                    Divider(),
                    AppSpacers.height10,
                    InformationBox(
                      target: data["target"].toString(),
                      device: data["device"].toString(),
                      subject: data["subject"].toString(),
                    ),
                    AppSpacers.height10,
                    Divider(),
                    AppSpacers.height10,
                    Container(
                      height: 400,
                      child: BaseSwitch3TapV2(
                        title1: "وصف الخدمة",
                        title2: "الإرشادات قبل وبعد",
                        title3: "التقييمات",
                        Widget1: SingleChildScrollView(
                          child: Container(
                            child: Html(
                              data: data["desc"].toString(),
                            ),
                          ),
                        ),
                        Widget2: SingleChildScrollView(
                          child: Container(
                            child: Html(
                              data: data["instructions"].toString(),
                            ),
                          ),
                        ),
                        Widget3: ReviewInformationView(),
                      ),
                    ),
                    AppSpacers.height12,
                    Divider(),
                    AppSpacers.height12,
                    Text(
                      'الأطباء الذين يقدمون هذه الخدمة',
                      style: TextStyle(
                        fontFamily: 'Effra',
                        fontSize: 16.0,
                        letterSpacing: 0.24,
                        fontWeight: FontWeight.w500,
                        height: 0.75,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    DoctorListView(),
                    AppSpacers.height60,
                  ],
                ),
              ));
        },
        onLoading: OnOfferLoadingView(),
      ),
    );
  }

  Widget InformationBox({
    required String? target,
    required String? device,
    required String? subject,
  }) {
    return DecoratedContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Column(
          children: [
            target == "null"
                ? SizedBox.shrink()
                : ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: // Group: Group 22341
                        Text(
                      'نوع الخدمة :',
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.19,
                        color: AppColors.greyColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    trailing: Text(
                      '${target}',
                      style: TextStyle(
                        fontFamily: 'Effra',
                        fontSize: 16.0,
                        height: 1.19,
                        color: AppColors.greyColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
            device == "null" ? SizedBox.shrink() : Divider(),
            device == "null"
                ? SizedBox.shrink()
                : ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: // Group: Group 22341
                        Text(
                      'نوع الجهاز :',
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.19,
                        color: AppColors.greyColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    trailing: Text(
                      '${device}',
                      style: TextStyle(
                        fontFamily: 'Effra',
                        fontSize: 16.0,
                        height: 1.19,
                        color: AppColors.greyColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
            subject == "null" ? SizedBox.shrink() : Divider(),
            subject == "null"
                ? SizedBox.shrink()
                : ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: // Group: Group 22341
                        Text(
                      'نوع المادة :',
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.19,
                        color: AppColors.greyColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    trailing: Text(
                      '${subject}',
                      style: TextStyle(
                        fontFamily: 'Effra',
                        fontSize: 16.0,
                        height: 1.19,
                        color: AppColors.greyColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget ReviewInformationBox({
    required String price,
    required String oldPrice,
    required String totalRateAvg,
    required String totalRateCount,
  }) {
    return Row(
      children: [
        PriceWithDiscountView(
          price: '${price}',
          hasDiscount: oldPrice != '0',
          oldPrice: '${oldPrice}',
        ),
        AppSpacers.width10,
        (totalRateCount == "0")
            ? SizedBox.shrink()
            : RatingBarView(
                initRating: double.tryParse(totalRateCount)!,
                totalRate: double.tryParse(totalRateAvg)!,
                ignoreGestures: true,
              ),
      ],
    );
  }

  Widget clinicInformationBox({
    required String title,
    required bool isFavorite,
    required void Function() onFavoriteTap,
    required void Function() onUploadTap,
  }) {
    return Row(
      children: [
        InkWell(
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
          onTap: () => Get.toNamed(Routes.CLINIC_INFO),
          child: Row(
            children: [
              Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFFF2E1E3),
                  border: Border.all(
                    width: 1.0,
                    color: AppColors.borderColor2,
                  ),
                ),
                child: Image.asset(
                  "assets/image/dummy/dummy_service.png",
                  width: 42,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                '${title}',
                style: TextStyle(
                  fontSize: 16.0,
                  letterSpacing: 0.16,
                  height: 1.19,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        Spacer(),
        FavoriteIconView(
          isFavorite: isFavorite,
          onFavoriteTapped: onFavoriteTap,
        ),
        AppSpacers.width10,
        ShareIconView(
          onShareTapped: onUploadTap,
        )
      ],
    );
  }
}
