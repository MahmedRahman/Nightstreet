import 'package:app_night_street/app/routes/app_pages.dart';
import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/custom_app_bar.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/component/address_item_builder.dart';
import '../controllers/addresses_controller.dart';

class AddressesView extends GetView<AddressesController> {
  const AddressesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: CustomAppBar(titleText: "العناوين"),
      child: ListView(
        padding: AppDimension.appPadding,
        children: [
          AddressItemBuilder(
            title: 'المنزل',
            description:
                'منوف شارعع مجلس المدينة ، عمارةع مجلس المدينة ، عمارةع مجلس المدينة ، عمارة ٤ب',
            onDeleteTapped: () {},
            onEditTapped: () {},
            onTap: () => Get.toNamed(Routes.COMPLETE_ORDER),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppDimension.appPadding.copyWith(
          bottom: 40,
        ),
        child: CustomButton.outLine(
          onPressed: () => Get.toNamed(Routes.NEW_ADDRESS),
          title: "إضافة عنوان جديد",
        ),
      ),
    );
  }
}
