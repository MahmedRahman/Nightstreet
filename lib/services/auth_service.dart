import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shopping_cart_controller.dart';
import 'package:krzv2/app/modules/verify_phone/views/verify_phone_view.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/models/user_data_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/cache_service.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

enum UserType { guest, registered }

enum AuthStatus { authenticated, unauthenticated, loading }

class AuthenticationController extends GetxController with CacheManager {
  bool get isLoggedIn => getUserToken() != null;

  String get token => getUserToken() ?? '';
  String get fireBaseToken => getFirebaseToken() ?? '';
  String get guestToken => getGuestToken() ?? '';
  bool get isGuestUser => (getUserType() ?? '') == UserType.guest.name;

  UserData? _userData;
  UserData? get userData => _userData;

  UserType _userType = UserType.guest;
  UserType get userType => _userType;

  final _authStatus = AuthStatus.loading.obs;
  AuthStatus get authStatus => _authStatus.value;

  void loginAsGuest({
    required String firebaseToken,
  }) async {
    EasyLoading.show();
    ResponseModel response = await WebServices().authNewGuest(
      firebasToken: firebaseToken,
    );
    EasyLoading.dismiss();
    if (!response.data["success"]) {
      return;
    }

    await removeUserToken();
    await removeGuestToken();
    await saveUserType(UserType.guest.name);
    _userData = null;

    await saveGuestToken(response.data['data']['token']);
    final cartController = Get.find<ShoppingCartController>();
    cartController.onInit();
    Get.find<MyBottomNavigationController>().changePage(0);
    Get.offAndToNamed(Routes.LAYOUT);
  }

  Future<void> loginWithPhoneNumber({
    required String phoneNumber,
    required String verificationCode,
    required String previousRoute,
    required Function() onError,
  }) async {
    EasyLoading.show();
    ResponseModel response = await WebServices().authLogin(
      phone: phoneNumber,
      code: verificationCode,
    );
    EasyLoading.dismiss();

    if (response.data["success"] == false) {
      AppDialogs.showToast(
        message: response.data["message"].toString(),
      );

      onError();
      return;
    }

    await saveUserToken(response.data["data"]["token"]);
    await saveUserType(UserType.registered.name);
    await removeGuestToken();

    Get.find<ShoppingCartController>().getCartProducts();

    _userData = UserData.fromJson(response.data["data"]);

    AppDialogs.loginSuccess();
    await Future.delayed(
      const Duration(milliseconds: 500),
      () {
        if (previousRoute == Routes.SHOPPINT_CART) {
          Get.back(closeOverlays: true);
        } else {
          Get.offAndToNamed(Routes.LAYOUT);
        }
      },
    );
  }

  Future<void> sendVerificationCode({
    required String phoneNumber,
  }) async {
    EasyLoading.show();
    ResponseModel response = await WebServices().authSendOtp(
      phone: phoneNumber,
    );

    EasyLoading.dismiss();
    if (response.data["success"] == false) {
      if (response.data["response_code"] == 403) {
        Get.toNamed(
          Routes.REGISTER,
          arguments: phoneNumber,
        );

        return;
      }

      AppDialogs.showToast(
        message: response.data["message"].toString(),
      );

      return;
    }

    Get.off(
      VerifyPhoneView(
        phoneNumber: phoneNumber,
        previousRoute: Get.previousRoute,
      ),
    );

    AppDialogs.showToast(
      message: response.data["message"].toString(),
    );
  }

  void reSendVerificationCode({required String phoneNumber}) {
    // Implementation
    sendVerificationCode(phoneNumber: phoneNumber);
  }

  void logout({required Function() onSuccess}) async {
    EasyLoading.show();
    ResponseModel response = await WebServices().authLogout();

    EasyLoading.dismiss();
    if (response.data["success"] == false) {
      AppDialogs.showToast(
        message: response.data["message"].toString(),
      );
      return;
    }
    await removeUserToken();
    await removeFirebaseToken();
    loginAsGuest(
      firebaseToken: getFirebaseToken().toString(),
    );
    AppDialogs.showToast(message: 'تم تسجيل الخروج بنجاح');
    onSuccess();
    Get.offAndToNamed(Routes.LAYOUT);

    _userData = null;
  }

  void deleteAccount() async {
    EasyLoading.show();
    ResponseModel response = await WebServices().deleteAccount();

    EasyLoading.dismiss();
    if (response.data["success"] == false) {
      AppDialogs.showToast(
        message: response.data["message"].toString(),
      );
      return;
    }
    await removeUserToken();
    await removeFirebaseToken();
    AppDialogs.showToast(message: 'تم حذف الحساب بنجاح');
    Get.offAndToNamed(Routes.LAYOUT);

    _userData = null;
  }

  void updateProfile({
    required String name,
    required String email,
    required String gender,
    required String birthDate,
  }) async {
    EasyLoading.show();
    ResponseModel response = await WebServices().authUpdateProfile(
      name: name,
      email: email,
      gender: gender,
      birthDate: birthDate,
    );
    EasyLoading.dismiss();

    if (response.data["success"] == false) {
      AppDialogs.showToast(message: response.data["message"]);
      return;
    }

    AppDialogs.showToast(message: response.data["message"]);
    _userData = UserData.fromJson(response.data["data"]);
    update();
    Get.back();
    return;
  }

  Future<void> getProfile() async {
    ResponseModel response = await WebServices().getAuthProfile();

    if (response.data["success"] == false) {
      AppDialogs.showToast(message: response.data["message"]);
      return;
    }

    _userData = UserData.fromJson(response.data["data"]);
    update();
    return;
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String firebasToken,
  }) async {
    EasyLoading.show();
    ResponseModel response = await WebServices().clientRegister(
      name: name,
      email: email,
      phone: phone,
      firebasToken: firebasToken,
    );

    EasyLoading.dismiss();
    if (response.data["success"] == false) {
      AppDialogs.showToast(
        message: response.data["message"].toString(),
      );

      return;
    }

    Get.to(
      VerifyPhoneView(
        phoneNumber: phone,
        previousRoute: Get.previousRoute,
      ),
    );
  }
}
