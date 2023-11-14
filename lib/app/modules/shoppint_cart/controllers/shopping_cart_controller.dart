import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/models/cart_summary_model.dart';
import 'package:krzv2/models/product_cart_model.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ShoppingCartController extends GetxController
    with StateMixin<List<MarketShippingCart>> {
  final List<MarketShippingCart> _products = [];
  // int get productCount => _products.length;
  RxString selectedMarketId = ''.obs;

  final cartSummaryModel = Rx<CartSummaryModel?>(null);

  @override
  void onInit() {
    if (Get.find<AuthenticationController>().isLoggedIn) getCartProducts();
    if (Get.find<AuthenticationController>().isGuestUser) getGuestCart();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getCartProducts() async {
    change([], status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getCartProducts();

    try {
      if (responseModel.data["success"]) {
        _products.clear();
        final List<MarketShippingCart> featchedData =
            List<MarketShippingCart>.from(
          responseModel.data['data']['data']
              .map((category) => MarketShippingCart.fromMap(category)),
        );

        // cartSummaryModel.value =
        //     CartSummaryModel.fromMap(responseModel.data['data']['cart']);

        _products.addAll(featchedData);

        if (_products.isEmpty) {
          change([], status: RxStatus.empty());
          return;
        }

        change(_products, status: RxStatus.success());
      }
    } catch (e, st) {
      print('error $e');
      print('stack $st');
    }
  }

  void addToCart({
    required String productId,
    required String quantity,
    String? variantId,
    required bool isNew,
  }) async {
    EasyLoading.show();
    ResponseModel response = await WebServices().addToCart(
      productId: productId,
      quantity: quantity,
      variantId: variantId,
      isNew: isNew,
    );
    EasyLoading.dismiss();
    if (!response.data["success"]) {
      AppDialogs.showToast(message: response.data["message"]);
      return;
    }

    getCartProducts();
    AppDialogs.showToast(message: response.data["message"]);
  }

  void deleteItemFromCart({required String productId}) async {
    EasyLoading.show();
    ResponseModel response = await WebServices().deleteProductFromCart(
      productId: productId,
    );
    EasyLoading.dismiss();
    if (!response.data["success"]) {
      AppDialogs.showToast(message: response.data["message"]);
      return;
    }

    getCartProducts();
    AppDialogs.showToast(message: response.data["message"]);
  }

  int get productCount {
    int total = 0;
    for (final product in _products) {
      total += product.marketProductCount;
    }
    return total;
  }

  /// --------------------- Guest Cart ------------------ ///

  getGuestCart() async {
    change([], status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getGuestCart();

    if (responseModel.data["success"]) {
      _products.clear();
      final List<MarketShippingCart> featchedData =
          List<MarketShippingCart>.from(
        responseModel.data['data']['data']
            .map((category) => MarketShippingCart.fromMap(category)),
      );

      // cartSummaryModel.value =
      //     CartSummaryModel.fromMap(responseModel.data['data']['cart']);

      _products.addAll(featchedData);

      if (_products.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(_products, status: RxStatus.success());
    }
  }

  void addToGuestCart({
    required String productId,
    required String quantity,
    String? variantId,
    required bool isNew,
  }) async {
    EasyLoading.show();
    ResponseModel response = await WebServices().addToGuestCart(
      productId: productId,
      quantity: quantity,
      variantId: variantId,
      isNew: isNew,
    );
    EasyLoading.dismiss();
    if (!response.data["success"]) {
      AppDialogs.showToast(message: response.data["message"]);
      return;
    }

    getGuestCart();
    AppDialogs.showToast(message: response.data["message"]);
  }

  void deleteGuestProductCart({required String productId}) async {
    EasyLoading.show();
    ResponseModel response = await WebServices().deleteGuestProductCart(
      productId: productId,
    );
    EasyLoading.dismiss();
    if (!response.data["success"]) {
      AppDialogs.showToast(message: response.data["message"]);
      return;
    }

    getGuestCart();
    AppDialogs.showToast(message: response.data["message"]);
  }
}
