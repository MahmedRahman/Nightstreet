import 'package:app_night_street/core/component/base_body.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/component/custom_app_bar.dart';
import '../controllers/new_address_controller.dart';

class NewAddressView extends GetView<NewAddressController> {
  const NewAddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: CustomAppBar(titleText: "إضافة عنوان جديد"),
      child: ListView(
        children: [],
      ),
    );
  }
}
