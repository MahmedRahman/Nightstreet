import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/appointment_status_view.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/price_with_discount_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class AppointmentCardView extends GetView {
  const AppointmentCardView({
    Key? key,
    required this.status,
    required this.mainButtonText,
    required this.secondButtonText,
    required this.mainButtonOnTap,
    required this.secondButtonOnTap,
    required this.offerName,
    required this.offerImage,
    required this.offerPrice,
    required this.offerOldPrice,
    required this.doctorName,
    required this.clinicName,
    required this.dateTime,
    required this.id,
  }) : super(key: key);

  final String status;
  final String mainButtonText;
  final String secondButtonText;
  final void Function()? mainButtonOnTap;
  final void Function()? secondButtonOnTap;

  final String offerName;
  final String offerImage;
  final String offerPrice;
  final String offerOldPrice;
  final String doctorName;
  final String clinicName;
  final String dateTime;
  final String id;

  AppointmentCardView.dummy({
    Key? key,
  })  : this.status = 'مؤكد',
        this.mainButtonText = '',
        this.secondButtonText = '',
        this.offerName = '',
        this.offerImage = '',
        this.offerPrice = '',
        this.offerOldPrice = '',
        this.doctorName = '',
        this.clinicName = '',
        this.id = '',
        this.dateTime = '',
        this.mainButtonOnTap = dummyFun,
        this.secondButtonOnTap = dummyFun;

  static void dummyFun() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.borderColor2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                DecoratedContainer(
                  child: Column(
                    children: [
                      AppointmentItemView(
                        image: offerImage,
                        price: offerPrice,
                        name: offerName,
                        oldPrice: offerOldPrice,
                        quantity: '',
                        status: status,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(),
                      ),
                      customTitle(
                        title: "اسم الطبيب",
                        subTitle: doctorName,
                      ),
                      dottedDivider,
                      customTitle(
                        title: "اسم العيادة",
                        subTitle: clinicName,
                      ),
                      dottedDivider,
                      customTitle(
                        title: "رقم الحجز",
                        subTitle: "#$id",
                      ),
                      dottedDivider,
                      customTitle(
                        title: "موعد الحجز",
                        subTitle: dateTime,
                      ),
                    ],
                  ),
                ),
                AppSpacers.height12,
                Row(
                  children: [
                    Expanded(
                      child: CustomBtnCompenent.main(
                        text: mainButtonText,
                        onTap: mainButtonOnTap!,
                      ),
                    ),
                    // AppSpacers.width10,
                    // Expanded(
                    //   child: CustomBtnCompenent.secondary(
                    //     text: secondButtonText,
                    //     onTap: secondButtonOnTap!,
                    //   ),
                    // )
                  ],
                ),
                AppSpacers.height12,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget customTitle({
    required String title,
    required String subTitle,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      dense: true,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Effra',
          fontSize: 14.0,
          color: AppColors.blackColor,
          height: 1.36,
        ),
        textAlign: TextAlign.right,
      ),
      trailing: Text(
        subTitle,
        style: TextStyle(
          fontFamily: 'Effra',
          fontSize: 14.0,
          color: AppColors.blackColor,
          height: 1.36,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget get dottedDivider => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DottedLine(
          dashLength: 10,
          dashGapLength: 5,
          lineThickness: 3,
          dashColor: AppColors.borderColor2,
        ),
      );
}

class AppointmentItemView extends GetView {
  AppointmentItemView({
    Key? key,
    required this.image,
    required this.price,
    required this.name,
    required this.oldPrice,
    required this.quantity,
    required this.status,
  }) : super(key: key);

  final String image;
  final String name;
  final String price;
  final String oldPrice;
  final String quantity;
  final String status;

  AppointmentItemView.dummy({required this.status})
      : image =
            'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1646077574-screen-shot-2022-02-28-at-2-39-10-pm-1646077556.png?crop=1xw:0.9974358974358974xh;center,top&resize=980:*',
        price = '100',
        name = 'مضاد التعرق كول راش من ديجري مين، يدوم لمدة 48 ساعة',
        oldPrice = '120',
        quantity = '2';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Row(
            children: [
              AppSpacers.width10,
              CashedNetworkImageView(
                width: 70,
                height: 70,
                imageUrl: image,
              ),
              AppSpacers.width10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width * .5,
                    ),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: const Color(0xFF1F1F1F),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  AppSpacers.height5,
                  PriceWithDiscountView(
                    price: price,
                    hasDiscount: oldPrice != '' && oldPrice != '0' ? true : false,
                    oldPrice: oldPrice != '' || oldPrice != '0' ? '' : oldPrice,
                  ),
                  AppSpacers.height5,
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: AppointmentStatusView(status: status),
          ),
        ],
      ),
    );
  }
}
