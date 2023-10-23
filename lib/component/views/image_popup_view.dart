import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/utils/app_colors.dart';

void displayImagePopup({required String iamgeUrl}) {
  Get.generalDialog(
    barrierDismissible: true,
    barrierLabel:
        MaterialLocalizations.of(Get.context!).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        ImagePopupView(
      imageUrl: iamgeUrl,
    ),
  );
}

class ImagePopupView extends GetView {
  const ImagePopupView({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width * .8,
        height: 440,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                right: 5,
              ),
              child: Align(
                child: InkWell(
                  onTap: () => Get.back(),
                  overlayColor: MaterialStatePropertyAll(
                    Colors.transparent,
                  ),
                  child: Icon(
                    Icons.cancel,
                    color: AppColors.mainColor,
                  ),
                ),
                alignment: Alignment.topRight,
              ),
            ),
            CashedNetworkImageView(
              boxFit: BoxFit.contain,
              imageUrl: imageUrl,
              width: Get.width * .7,
              height: 400,
            ),
          ],
        ),
      ),
    );
  }
}
