import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:krzv2/app/modules/shoppint_cart/controllers/shoppint_cart_controller.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/component/views/toast_component.dart';
import 'package:krzv2/models/user_data_model.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/cache_service.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

enum UserType { guest, registered }

enum AuthStatus { authenticated, unauthenticated, loading }

class AuthenticationController extends GetxController with CacheManager {
  bool get isLoggedIn => getUserToken() != null;

  String get token => getUserToken() ?? '';
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

    print('after new login guest token => ${guestToken}');

    await saveGuestToken(response.data['data']['token']);
    final cartController = Get.find<ShoppintCartController>();
    cartController.onInit();

    Get.offAndToNamed(Routes.LAYOUT);
  }

  Future<void> loginWithPhoneNumber({
    required String phoneNumber,
    required String verificationCode,
    required Function() onError,
  }) async {
    EasyLoading.show();
    ResponseModel response = await WebServices().authLogin(
      phone: phoneNumber,
      code: verificationCode,
    );
    EasyLoading.dismiss();

    if (response.data["success"] == false) {
      showToast(
        message: response.data["message"].toString(),
      );

      onError();
      return;
    }

    await saveUserToken(response.data["data"]["token"]);
    await saveUserType(UserType.registered.name);
    await removeGuestToken();

    Get.find<ShoppintCartController>().getCartProducts();

    _userData = UserData.fromJson(response.data["data"]);

    AppDialogs.loginSuccess();
    await Future.delayed(
      const Duration(milliseconds: 500),
      () => Get.offAndToNamed(Routes.LAYOUT),
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

      showToast(
        message: response.data["message"].toString(),
      );

      return;
    }

    Get.toNamed(
      Routes.VERIFY_PHONE,
      arguments: phoneNumber,
    );
    showToast(
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
      showToast(
        message: response.data["message"].toString(),
      );
      return;
    }
    await removeUserToken();
    await removeFirebaseToken();
    showToast(message: 'تم تسجيل الخروج بنجاح');
    onSuccess();
    Get.offAndToNamed(Routes.LAYOUT);

    _userData = null;
  }

  void deleteAccount() async {
    EasyLoading.show();
    ResponseModel response = await WebServices().deleteAccount();

    EasyLoading.dismiss();
    if (response.data["success"] == false) {
      showToast(
        message: response.data["message"].toString(),
      );
      return;
    }
    await removeUserToken();
    await removeFirebaseToken();
    showToast(message: 'تم حذف الحساب بنجاح');
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
      showToast(message: response.data["message"]);
      return;
    }

    showToast(message: response.data["message"]);
    _userData = UserData.fromJson(response.data["data"]);
    update();
    Get.back();
    return;
  }

  Future<void> getProfile() async {
    ResponseModel response = await WebServices().getAuthProfile();

    if (response.data["success"] == false) {
      showToast(message: response.data["message"]);
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
      showToast(
        message: response.data["message"].toString(),
      );

      return;
    }

    Get.toNamed(
      Routes.VERIFY_PHONE,
      arguments: phone,
    );
  }
}
