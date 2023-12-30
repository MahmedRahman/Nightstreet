import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/custom_app_bar.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppDimension.appPadding.copyWith(
          bottom: 40,
        ),
        child: CustomButton.outLine(
          onPressed: () {},
          title: "اضافة عنوان جديد",
        ),
      ),
    );
  }
}
