import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
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
      body: ListView(
        padding: AppDimension.appPadding,
        children: [
          customListTile(
            leading: Container(
              width: 54.0,
              height: 54.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mainColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  AppSvgAssets.homeIcon,
                  color: Colors.white,
                ),
              ),
            ),
            title: 'المنزل',
            subTitle: 'الدمام - ضاحية الملك فهد',
            trailing: DecoratedContainer(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'افتراضي',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.blackColor,
                    letterSpacing: 0.24,
                    height: 1.0,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          customListTile(
            leading: Container(
              width: 54.0,
              height: 54.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.greyColor4,
                border: Border.all(
                  width: 1.0,
                  color: AppColors.borderColor2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  AppSvgAssets.summerIcon,
                ),
              ),
            ),
            title: "الاستراحة",
            subTitle: 'الدمام - ضاحية الملك فهد',
            trailing: DecoratedContainer(
              width: 40,
              height: 40,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    AppSvgAssets.deleteIcon,
                    color: AppColors.greyColor,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          customListTile(
            leading: Container(
              width: 54.0,
              height: 54.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.greyColor4,
                border: Border.all(
                  width: 1.0,
                  color: AppColors.borderColor2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  AppSvgAssets.workIcon,
                ),
              ),
            ),
            title: "الاستراحة",
            subTitle: 'الدمام - ضاحية الملك فهد',
            trailing: DecoratedContainer(
              width: 40,
              height: 40,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    AppSvgAssets.deleteIcon,
                    color: AppColors.greyColor,
                  )),
            ),
          ),
        ],
      ),
      bottomBarHeight: 143,
      bottomNavigationBar: Padding(
        padding: AppDimension.appPadding,
        child: CustomBtnCompenent.main(
          text: 'إضافة عنوان جديد',
          onTap: () => Get.toNamed(Routes.ADD_NEW_ADDRESS),
        ),
      ),
    );
  }

  ListTile customListTile({
    required Widget leading,
    required String title,
    required String subTitle,
    required Widget trailing,
  }) {
    return ListTile(
      leading: leading,
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
}
