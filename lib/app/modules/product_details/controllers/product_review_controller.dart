import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:krzv2/models/review_model.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ProductReviewController extends GetxController
    with ScrollMixin, StateMixin<List<ReviewModel>> {
  final List<ReviewModel> _reviews = [];
  int currentPage = 1;
  bool? isPagination;
  RxString productId = '0'.obs;

  @override
  void onInit() {
    productId.value = Get.arguments as String;
    change([], status: RxStatus.empty());
    getProductReviews();
    super.onInit();
  }

  resetSearchValues() {
    _reviews.clear();

    currentPage = 1;
  }

  getProductReviews() async {
    if (currentPage == 1) change([], status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getProductRates(
      id: productId.value,
      page: currentPage.toString(),
    );

    if (responseModel.data["success"]) {
      final List<ReviewModel> reviewsDataList = List<ReviewModel>.from(
        responseModel.data['data']['data']
            .map((category) => ReviewModel.fromJson(category)),
      );

      _reviews.addAll(reviewsDataList);

      if (_reviews.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(_reviews, status: RxStatus.success());

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
    }
  }

  @override
  Future<void> onEndScroll() async {
    if (isPagination == false) return;
    currentPage++;

    Get.dialog(
      const Center(
        child: SpinKitCircle(
          color: AppColors.mainColor,
          size: 70,
        ),
      ),
    );

    await getProductReviews();

    Get.back();
  }

  @override
  Future<void> onTopScroll() {
    // TODO: implement onTopScroll
    throw UnimplementedError();
  }
}
