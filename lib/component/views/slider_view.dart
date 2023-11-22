import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/cashed_network_image_view.dart';
import 'package:krzv2/utils/app_colors.dart';

class SliderView extends GetView {
  SliderView({
    Key? key,
    required this.images,
    this.height = 150,
  }) : super(key: key);

  List<String> images = [];
  final double height;

  SliderView.dyume(this.height) {
    images.addAll([
      "https://images.unsplash.com/photo-1698440235228-9c617924c06e?q=80&w=3920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1698440235228-9c617924c06e?q=80&w=3920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1698440235228-9c617924c06e?q=80&w=3920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1698440235228-9c617924c06e?q=80&w=3920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1698440235228-9c617924c06e?q=80&w=3920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1698440235228-9c617924c06e?q=80&w=3920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    ]);
  }

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

class SliderHomePageView extends GetView {
  SliderHomePageView({
    Key? key,
    required this.images,
    this.height = 150,
    this.onSliderTap,
  }) : super(key: key);

  List images = [];
  final double height;
  Function(Map<String, dynamic> Slider)? onSliderTap;

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
              items: List.generate(
                images.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      print(images.elementAt(index).toString());

                      this.onSliderTap!(images.elementAt(index));
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: CashedNetworkImageView(
                        boxFit: BoxFit.cover,
                        imageUrl: images.elementAt(index)["image"],
                      ),
                    ),
                  );
                },
              ),
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
    required List images,
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
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.fastEaseInToSlowEaseOut,
      margin: const EdgeInsets.only(
        left: 6,
      ),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.mainColor : Colors.white,
      ),
    );
  }
}
