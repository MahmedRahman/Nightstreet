import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/utils/app_colors.dart';

class SliderView extends GetView {
  const SliderView({
    Key? key,
    required this.images,
    this.height = 150,
  }) : super(key: key);

  final List<String> images;
  final double height;

  @override
  Widget build(BuildContext context) {
    RxInt imageIndex = 0.obs;

    return Obx(
      () => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: height,
            width: double.infinity,
            child: CarouselSlider(
              items: images
                  .map(
                    (e) => SizedBox(
                      width: double.infinity,
                      child: CashedNetworkImageView(
                        boxFit: BoxFit.cover,
                        imageUrl: e,
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
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(
                images: images,
                index: imageIndex.value,
              ).toList(),
            ),
          ),
        ],
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
      margin: const EdgeInsets.only(left: 6),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.mainColor : Colors.white,
      ),
    );
  }
}
