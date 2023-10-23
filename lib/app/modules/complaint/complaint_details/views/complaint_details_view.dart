import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/wallet/components/decorated_container_component.dart';
import 'package:krzv2/component/views/complant_details_item_view.dart';
import 'package:krzv2/component/views/complant_status_view.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/component/views/custom_app_bar.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/custom_text_field_component.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_dimens.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:validator/validator.dart';

import '../controllers/complaint_details_controller.dart';

class ComplaintDetailsView extends GetView {
  ComplaintDetailsController controller = Get.put(ComplaintDetailsController());
  TextEditingController text = TextEditingController();
  final String complaintID;
  ComplaintDetailsView(this.complaintID);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    controller.getComplaintsDetails(
      complaintID: complaintID,
    );
    return controller.obx((snapshot) {
      return Scaffold(
        appBar: CustomAppBar(
          titleText: 'تفاصيل الشكوى',
        ),
        body: Column(
          children: [
            compiantInfo(
              title: snapshot["complaint"]["description"].toString() ?? '',
              complaintCode: "#${snapshot["complaint"]["id"].toString()}",
              isActiveComplaint: !snapshot["complaint"]["closed"],
              statusTitle: snapshot["complaint"]["status"],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.getComplaintsDetails(complaintID: complaintID);
                },
                child: ListView.builder(
                  controller: controller.scrollController,
                  padding:
                      AppDimension.appPadding + EdgeInsets.only(bottom: 270),
                  itemCount: snapshot["chats"]["data"].length,
                  reverse: false,
                  itemBuilder: (context, index) {
                    AuthenticationController auth = Get.find();

                    final isLoggedInUser = snapshot["chats"]["data"][index]
                                ["sender_id"]
                            .toString() ==
                        auth.userData!.id.toString();

                    return ComplantDetailsItemView(
                      isLoggedInUser: isLoggedInUser,
                      messageTime: DateTime.parse(
                          snapshot["chats"]["data"][index]["date"].toString()),
                      message: snapshot["chats"]["data"][index]["message"]
                          .toString(),
                    );
                  },
                ),
              ),
            )
          ],
        ),
        bottomSheet: Form(
          key: formKey,
          child: Container(
            color: Colors.white,
            height: 270,
            child: Padding(
              padding: AppDimension.appPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacers.height10,
                  Divider(),
                  TextFieldComponent.longMessage(
                    maxLines: 5,
                    controller: text,
                    outLineText: '',
                    hintText: 'أدخل ردك',
                    isRequired: true,
                    validator: customValidator(
                      rules: [
                        IsRequired(message: 'حقل مطلوب'),
                        IsBetween(min: 5, max: 100),
                      ],
                    ),
                  ),
                  AppSpacers.height12,
                  CustomBtnCompenent.main(
                    width: 130,
                    text: 'إرسال',
                    onTap: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      if (GetUtils.isNullOrBlank(text.text.toString()) ==
                          true) {
                        AppDialogs.showToast(message: "برجاء كتابه الرساله");

                        return;
                      }

                      controller.SendComplaints(
                        message: text.text,
                        complaintID: complaintID,
                      );

                      text.clear();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget compiantInfo({
    required String title,
    required String complaintCode,
    required String statusTitle,
    required bool isActiveComplaint,
  }) {
    return DecoratedContainer(
      child: Row(
        children: [
          Padding(
            padding: AppDimension.appPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacers.height10,
                ComplantStatusView(
                  isActiveComplaint: isActiveComplaint,
                  statusTitle: statusTitle,
                ),
                AppSpacers.height12,
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.blackColor,
                    letterSpacing: 0.8,
                    height: 1.38,
                  ),
                  textAlign: TextAlign.right,
                ),
                AppSpacers.height12,
                Text(
                  complaintCode,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.blackColor,
                    letterSpacing: 0.8,
                    height: 1.38,
                  ),
                  textAlign: TextAlign.right,
                ),
                AppSpacers.height10,
              ],
            ),
          )
        ],
      ),
    );
  }
}
