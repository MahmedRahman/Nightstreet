import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/address/edit_address/views/edit_address_view.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/pages/app_page_error.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_svg_paths.dart';

import '../controllers/delivery_addresses_controller.dart';

class DeliveryAddressesView extends GetView<DeliveryAddressesController> {
  const DeliveryAddressesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(titleText: 'عناوين التوصيل'),
      onRefresh: () async {
        controller.getAddress();
      },
      body: controller.obx(
        (data) {
          return ListView(
            padding: AppDimension.appPadding,
            children: List.generate(
              data!.length,
              (index) {
                return customListTile(
                  onTap: () {
                    Get.to(
                      editAddressView(
                        data: data[index],
                      ),
                    );
                  },
                  leading: Container(
                    width: 54.0,
                    height: 54.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.0,
                        color: data[index]["is_default"] == 1
                            ? AppColors.mainColor
                            : AppColors.borderColor2,
                      ),
                      color: data[index]["is_default"] == 1
                          ? AppColors.mainColor
                          : AppColors.greyColor4,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset(
                        getIconByNotes(
                          data[index]["notes"] ?? '',
                        ),
                        color: data[index]["is_default"] == 1
                            ? Colors.white
                            : AppColors.blackColor,
                      ),
                    ),
                  ),
                  title: data[index]["notes"] ?? '',
                  subTitle: data[index]["address"],
                  trailing: DecoratedContainer(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (data[index]["is_default"] == 1)
                            ? Text(
                                'افتراضي',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: AppColors.blackColor,
                                  letterSpacing: 0.24,
                                  height: 1.0,
                                ),
                                textAlign: TextAlign.right,
                              )
                            : DecoratedContainer(
                                child: InkWell(
                                  child: SvgPicture.asset(
                                      AppSvgAssets.outlineDeleteIcon),
                                  onTap: () {
                                    controller.activationAddresses(
                                      id: data[index]["id"].toString(),
                                    );
                                  },
                                ),
                              )),
                  ),
                );
              },
            ),
          );
        },
        onEmpty: AppPageEmpty.addressesList(),
        onError: (error) {
          return AppPageError();
        },
        onLoading: ListView.builder(
          padding: AppDimension.appPadding,
          itemCount: 3,
          itemBuilder: (_, __) {
            return Container(
              height: 90,
              margin: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ).shimmer();
          },
        ),
      ),
      bottomBarHeight: 143,
      bottomNavigationBar: Padding(
        padding: AppDimension.appPadding,
        child: CustomBtnCompenent.main(
          text: 'إضافة عنوان جديد',
          onTap: () {
            Get.toNamed(Routes.ADD_NEW_ADDRESS);
          },
        ),
      ),
    );
  }

  Widget customListTile({
    required Widget leading,
    required String title,
    required String subTitle,
    required Widget trailing,
    required void Function()? onTap,
  }) {
    return ListTile(
      leading: leading,
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14.0,
          color: AppColors.blackColor,
          letterSpacing: 0.28,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.right,
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(
          fontSize: 14.0,
          color: AppColors.greyColor,
          letterSpacing: 0.28,
        ),
        textAlign: TextAlign.right,
      ),
      trailing: trailing,
    );
  }

  String getIconByNotes(String notes) {
    switch (notes) {
      case "المنزل":
        return AppSvgAssets.homeIcon;
      case "العمل":
        return AppSvgAssets.workIcon;
      case "العائلة":
        return AppSvgAssets.familyIcon;
      case "الاستراحة":
        return AppSvgAssets.restIcon;
      default:
        return AppSvgAssets.homeIcon;
    }
  }
}
