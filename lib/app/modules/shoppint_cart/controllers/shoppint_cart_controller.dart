import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/models/cart_summary_model.dart';
import 'package:krzv2/models/product_cart_model.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ShoppintCartController extends GetxController
    with StateMixin<List<ProductCartModel>> {
  final List<ProductCartModel> _products = [];
  int get productCount => _products.length;

  final cartSummaryModel = Rx<CartSummaryModel?>(null);

  @override
  void onInit() {
    print(
        'cart , isLoggedIn => ${Get.find<AuthenticationController>().isLoggedIn}');
    print(
        'cart , isGuestUser => ${Get.find<AuthenticationController>().isGuestUser}');
    print(
        'cart , guestToken => ${Get.find<AuthenticationController>().guestToken}');
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

    if (responseModel.data["success"]) {
      _products.clear();
      final List<ProductCartModel> featchedData = List<ProductCartModel>.from(
        responseModel.data['data']['data']
            .map((category) => ProductCartModel.fromMap(category)),
      );

      cartSummaryModel.value =
          CartSummaryModel.fromMap(responseModel.data['data']['cart']);

      _products.addAll(featchedData);

      if (_products.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(_products, status: RxStatus.success());
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

  /// --------------------- Guest Cart ------------------ ///

  getGuestCart() async {
    change([], status: RxStatus.loading());

    ResponseModel responseModel = await WebServices().getGuestCart();

    if (responseModel.data["success"]) {
      _products.clear();
      final List<ProductCartModel> featchedData = List<ProductCartModel>.from(
        responseModel.data['data']['data']
            .map((category) => ProductCartModel.fromMap(category)),
      );

      cartSummaryModel.value =
          CartSummaryModel.fromMap(responseModel.data['data']['cart']);

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
