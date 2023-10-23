import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/component/views/order_details_card_view.dart';
import 'package:krzv2/component/views/rating_bar_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/order_review_controller.dart';

class OrderReviewView extends GetView<OrderReviewController> {
  const OrderReviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: CustomAppBar(titleText: 'تقييم الطلب'),
      body: ListView.separated(
        padding: AppDimension.appPadding,
        itemBuilder: (context, index) {
          return ProductRateForm();
        },
        separatorBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        itemCount: 5,
      ),
    );
  }
}

class ProductRateForm extends StatelessWidget {
  const ProductRateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OrderDetailsCardView.demmy(),
        Divider(),
        AppSpacers.height12,
        Text(
          'ما تقييمك لهذا المنتج ؟',
          style: TextStyle(
            fontSize: 16.0,
            color: AppColors.blackColor,
            letterSpacing: 0.24,
            height: 0.75,
          ),
          textAlign: TextAlign.right,
        ),
        AppSpacers.height12,
        RatingBarView(
          initRating: 0,
          totalRate: 0,
          displayTotalRate: false,
          itemSize: 20,
        ),
        AppSpacers.height12,
        Divider(),
        TextFieldComponent.longMessage(
          controller: TextEditingController(),
          outLineText: '',
          hintText: 'اكتب شيئًا عن هذا المنتج',
        ),
        AppSpacers.height12,
        Row(
          children: [
            CustomBtnCompenent.main(
              width: 130,
              text: 'إرسال',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
