import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/component/views/rating_bar_view.dart';
import 'package:krzv2/models/appointment_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

import '../controllers/service_review_controller.dart';

class ServiceReviewView extends GetView<ServiceReviewController> {
  final serviceMessageController = TextEditingController();
  final branchMessageController = TextEditingController();
  final doctorMessageController = TextEditingController();

  final serviceRate = 1.0.obs;
  final branchRate = 1.0.obs;
  final doctorRate = 1.0.obs;
  @override
  Widget build(BuildContext context) {
    final appointment = Get.arguments as AppointmentModel;
    return Scaffold(
      appBar: CustomAppBar(titleText: "تقييم الخدمة"),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DecoratedContainer(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacers.height12,
                    Text(
                      'اسم الخدمة',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    AppSpacers.height10,
                    Text(
                      appointment.offer.name,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.blackColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    AppSpacers.height10,
                    Divider(
                      height: 2,
                      color: AppColors.greyColor,
                    ),
                    AppSpacers.height10,
                    Text(
                      'ما تقييمك لهذه الخدمة ؟',
                      style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 0.24,
                        height: 0.75,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    AppSpacers.height10,
                    RatingBarView(
                      initRating: 1,
                      totalRate: 5,
                      displayTotalRate: false,
                      onRatingUpdate: (double vlu) {
                        serviceRate.value = vlu;
                      },
                    ),
                    AppSpacers.height10,
                    TextFieldComponent.longMessage(
                      controller: serviceMessageController,
                      outLineText: "",
                      hintText: "اكتب شيئًا عن هذا الخدمة",
                    ),
                    AppSpacers.height10,
                    CustomBtnCompenent.main(
                      width: 120,
                      text: "إرسال",
                      onTap: () {
                        controller.rateOffer(
                          appointmentId: appointment.id.toString(),
                          offerId: appointment.offer.id.toString(),
                          rate: serviceRate.value.toInt().toString(),
                          message: serviceMessageController.text,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DecoratedContainer(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacers.height10,
                    Text(
                      'ما تقييمك لهذا المركز ؟',
                      style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 0.24,
                        height: 0.75,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    AppSpacers.height10,
                    RatingBarView(
                      initRating: 1,
                      totalRate: 5,
                      displayTotalRate: false,
                      onRatingUpdate: (double vlu) {
                        branchRate.value = vlu;
                      },
                    ),
                    AppSpacers.height10,
                    TextFieldComponent.longMessage(
                      controller: branchMessageController,
                      outLineText: "",
                      hintText: "اكتب شيئًا عن هذا الخدمة",
                    ),
                    AppSpacers.height10,
                    CustomBtnCompenent.main(
                      width: 120,
                      text: "إرسال",
                      onTap: () {
                        controller.rateBranch(
                          appointmentId: appointment.id.toString(),
                          branchId: appointment.branchId.toString(),
                          rate: branchRate.value.toInt().toString(),
                          message: branchMessageController.text,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DecoratedContainer(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacers.height10,
                    Text(
                      'ما تقييمك للطبيب المنفذ للخدمة ؟؟',
                      style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 0.24,
                        height: 0.75,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    AppSpacers.height10,
                    RatingBarView(
                      initRating: 1,
                      totalRate: 5,
                      displayTotalRate: false,
                      onRatingUpdate: (double vlu) {
                        doctorRate.value = vlu;
                      },
                    ),
                    AppSpacers.height10,
                    TextFieldComponent.longMessage(
                      controller: doctorMessageController,
                      outLineText: "",
                      hintText: "اكتب شيئًا عن هذا الخدمة",
                    ),
                    AppSpacers.height10,
                    CustomBtnCompenent.main(
                      width: 120,
                      text: "إرسال",
                      onTap: () {
                        controller.rateDoctor(
                          appointmentId: appointment.id.toString(),
                          doctorId: appointment.doctorId.toString(),
                          rate: doctorRate.value.toInt().toString(),
                          message: doctorMessageController.text,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
