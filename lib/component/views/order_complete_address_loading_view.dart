import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/extensions/widget.dart';
import 'package:krzv2/utils/app_dimens.dart';

class OrderCompleteAddressLoadingView extends GetView {
  const OrderCompleteAddressLoadingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(titleText: 'إتمام الطلب'),
      body: ListView.builder(
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
    );
  }
}
