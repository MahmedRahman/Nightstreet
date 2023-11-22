import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/component/views/image_popup_view.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';

class ImageSwpierView extends GetView {
  const ImageSwpierView({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    RxInt imageIndex = 0.obs;

    return Container(
      width: double.infinity,
      height: 260.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        border: Border.all(
          width: 1.0,
          color: AppColors.borderColor2,
        ),
      ),
      child: Obx(
        () => Column(
          children: [
            CarouselSlider(
              items: images
                  .map(
                    (e) => InkWell(
                      overlayColor: MaterialStatePropertyAll(Colors.transparent),
                      onTap: () => displayImagePopup(iamgeUrl: e),
                      child: SizedBox(
                        width: Get.width,
                        //height: 200,
                        child: CashedNetworkImageView(
                          boxFit: BoxFit.fill,
                          imageUrl: e,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                onPageChanged: ((index, reason) {
                  imageIndex.value = index;
                }),
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                viewportFraction: 1,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
              ),
            ),
            AppSpacers.height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(
                images: images,
                index: imageIndex.value,
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator({
    required List<String> images,
    required int index,
  }) {
    List<Widget> list = [];
    for (int i = 0; i < images.length; i++) {
      list.add(i == index ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastEaseInToSlowEaseOut,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? AppColors.mainColor : Colors.transparent,
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastEaseInToSlowEaseOut,
        margin: const EdgeInsets.all(2),
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? AppColors.mainColor : AppColors.greyColor,
        ),
      ),
    );
  }
}
