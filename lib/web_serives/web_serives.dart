import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:krzv2/models/branch_url_model.dart';
import 'package:krzv2/models/product_search_query.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/api_manger.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';

class WebServices {
  //final ApiClient apiclient;
  //this.apiclient
  WebServices();
  Future<ResponseModel> getSetting() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/setting/get-setting",
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> getAppVersion() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/setting/app-version",
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> authLogin({
    required String phone,
    required String code,
  }) async {
    final authController = Get.put(AuthenticationController());

    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/auth/login",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "phone": phone,
        "code": code,
        "firebase_token": authController.fireBaseToken,
        "guest_token": authController.isGuestUser ? authController.guestToken : '',
      },
    );
  }

  Future<ResponseModel> updatePhone({
    required String phone,
    required String code,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/auth/update-phone",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: {
        "phone": phone,
        "code": code,
      },
    );
  }

  Future<ResponseModel> clientRegister({
    required String name,
    required String email,
    required String phone,
    required String firebasToken,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/auth/client-register",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "name": name,
        "email": email,
        "phone": phone,
        "gender": "male",
        "firebas_token": firebasToken,
        // "firebas_token": firebasToken,
      },
    );
  }

  Future<ResponseModel> authSendOtp({
    required String phone,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/auth/send-otp",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "phone": phone,
      },
    );
  }

  Future<ResponseModel> sendOtpUpdatePhone({
    required String phone,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/auth/send-otp-update-phone",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: {
        "phone": phone,
      },
    );
  }

  Future<ResponseModel> getAuthProfile() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/auth/profile",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> authUpdateProfile({
    required String name,
    required String email,
    required String gender,
    required String birthDate,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/auth/update-profile",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: {
        "name": name,
        "email": email,
        "gender": gender,
        "birth_date": birthDate,
      },
    );
  }

  Future<ResponseModel> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/auth/change-password",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: {
        "old_password": oldPassword,
        "new_password": newPassword,
        "confirm_new_password": confirmNewPassword,
      },
    );
  }

  Future<ResponseModel> authLogout() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/auth/logout",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
    );
  }

  Future<ResponseModel> authNewGuest({
    required String firebasToken,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/auth/new-guest",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "firebas_token": firebasToken,
      },
    );
  }

  Future<ResponseModel> deleteAccount() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/auth/delete-account",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
    );
  }

  Future<ResponseModel> fetchNotifications({
    required int page,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/notifications/get?page=$page",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> readNotifications({
    required int id,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/notifications/read-one",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: {
        "id": id,
      },
    );
  }

  Future<ResponseModel> getComplaintsCategories() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/complaints/categories",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getComplaints({
    required int filter,
    required int page,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/complaints/get?page&filter=${filter.toString()}&page=$page",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getComplaintsDetails({
    required String complaintID,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/complaints/get-chats?complaint_id=${complaintID.toString()}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> setComplaints({
    required String message,
    required String complaintID,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/complaints/store-chat",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "message": "$message",
        "complaint_id": "$complaintID",
      },
      isAuth: true,
    );
  }

  Future<ResponseModel> walletRedeem({
    required String code,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/coupons/redeem",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "code": code,
      },
      isAuth: true,
    );
  }

  Future<ResponseModel> getTransactions({required int pageNo}) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/wallet/get-transactions?page=$pageNo",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getNotifications() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/notifications/get",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> readAllNotifications() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/notifications/read-all",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
    );
  }

  Future<ResponseModel> getCities() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/setting/cities",
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> getCategories({
    required String name,
    required String category_id,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/complaints/categories?name={$name}&category_id={$category_id}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  FormData? _formData;
  Future<ResponseModel> addComplaintsStore({
    required String description,
    required String categoryId,
    File? file,
  }) async {
    try {
      _formData = FormData(
        {
          if (file != null)
            'attachment': MultipartFile(
              file,
              filename: getFileNameFromFile(file),
            ),
          "description": description,
          "category_id": categoryId,
        },
      );
    } catch (e) {}

    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/complaints/store",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: _formData,
      isAuth: true,
    );
  }

  String getFileNameFromFile(File file) {
    final filePath = file.path;
    final lastIndex = filePath.lastIndexOf('/');
    if (lastIndex != -1 && lastIndex < filePath.length - 1) {
      // Extract the file name from the path.
      return filePath.substring(lastIndex + 1);
    }
    // Handle cases where the file is null or the name couldn't be extracted.
    return '';
  }

  Future<ResponseModel> getSliderSetting({required String type}) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/setting/slider?type=$type",
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> getAddresses() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/addresses/get",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> saveAddresses({
    required String cityId,
    required String phone,
    required String address,
    required String email,
    required String name,
    required String notes,
    required String isDefault,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/addresses/save",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: {
        "city_id": "$cityId",
        "phone": "$phone",
        "address": "$address",
        "email": "$email",
        "name": "$name",
        "notes": "$notes",
        "is_default": "$isDefault",
      },
    );
  }

  Future<ResponseModel> updateAddresses({
    required int id,
    required String cityId,
    required String phone,
    required String address,
    required String notes,
    required String isDefault,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/addresses/update",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: {
        "id": id,
        "city_id": "$cityId",
        "phone": "$phone",
        "address": "$address",
        "notes": "$notes",
        "is_default": "$isDefault",
      },
    );
  }

  Future<ResponseModel> bookAppointment({
    required String payment_type,
    required int offer_id,
    required int branch_id,
    required int? doctor_id,
    required String date_time,
    required String time,
    required String notes,
  }) async {
    if (doctor_id == null) {
      return await ApiManger().execute(
        url: "${ApiConfig.baseUrl}/appointments/book-appointment",
        HTTPRequestMethod: HTTPRequestEnum.POST,
        isAuth: true,
        query: {
          "payment_type": "$payment_type",
          "offer_id": offer_id,
          "branch_id": branch_id,
          "date_time": "$date_time",
          "time": "$time",
          "notes": "$notes",
        },
      );
    }

    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/appointments/book-appointment",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: {
        "payment_type": "$payment_type",
        "offer_id": offer_id,
        "branch_id": branch_id,
        "doctor_id": doctor_id,
        "date_time": "$date_time",
        "time": "$time",
        "notes": "$notes",
      },
    );
  }

  Future<ResponseModel> activationAddresses({
    required String id,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/addresses/activation",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: {
        "id": "$id",
      },
    );
  }

  Future<ResponseModel> getProductsCategories({
    String? name = "",
    String? categoryId = "",
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/products/categories?name=${name}&category_id=${categoryId}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getProductsByMarketId({
    String? id = "",
    String? page = "1",
    String? categoryId = '',
  }) async {
    String url = '${ApiConfig.baseUrl}/products/get?market_id=${id}&page=${page}';
    print('categoryIdcategoryId =>${categoryId == null}');

    if (categoryId != null) {
      url += '&category_id=$categoryId';
    }
    return await ApiManger().execute(
      url: url,
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getBranchOfferDoctors({
    required int branchId,
    required int offerId,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/branches/branch-offer-doctors?branch_id=${branchId}&offer_id=${offerId}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getAvailableOfferTimes({
    required int offerId,
    required int branchId,
    required int? doctorId,
    required String dateTime,
  }) async {
    if (doctorId == null) {
      return await ApiManger().execute(
        url:
            "${ApiConfig.baseUrl}/appointments/get-available-offer-times?offer_id=${offerId}&branch_id=${branchId}&date_time=${dateTime}",
        HTTPRequestMethod: HTTPRequestEnum.GET,
        isAuth: true,
      );
    }

    return await ApiManger().execute(
      url:
          "${ApiConfig.baseUrl}/appointments/get-available-offer-times?offer_id=${offerId}&branch_id=${branchId}&doctor_id=${doctorId}&date_time=${dateTime}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getServicesCategories({
    String? categoryId = "",
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/offers/categories?&category_id=${categoryId}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> setBookAppointment({
    String? name = "",
    String? categoryId = "",
  }) async {
    return await ApiManger().execute(
        url: "${ApiConfig.baseUrl}/appointments/book-appointment",
        HTTPRequestMethod: HTTPRequestEnum.POST,
        isAuth: true,
        //query: {"payment_type": "", "offer_id": "", "branch_id": "", "doctor_id": "", "date_time": ""});
        query: {"payment_type": "", "offer_id": "", "branch_id": "", "doctor_id": "", "date_time": ""});
  }

  Future<ResponseModel> getProductsBrands() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/products/brands",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getBranches({
    required int page,
    BranchQueryParameters? queryParameters,
  }) async {
    return await ApiManger().execute(
      url: buildBranchesUrl(
        ApiConfig.baseUrl,
        page,
        queryParams: queryParameters,
      ),
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> getProducts({
    int? page = 1,
    ProductQueryParameters? queryParameters,
  }) async {
    print('product url => ${buildProductUrl(
      ApiConfig.baseUrl,
      page!,
      queryParams: queryParameters,
    )}');
    return await ApiManger().execute(
      url: buildProductUrl(
        ApiConfig.baseUrl,
        page,
        queryParams: queryParameters,
      ),
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getServices({
    String? page = '1',
    String? categoryId,
    String? name,
    String? startPrice,
    String? endPrice,
    String? filter,
    String? branchId,
    String? clinicId,
    String? clinicFeatured,
    String? adminFeatured,
    String? target,
  }) async {
    final queryParams = <String, String>{};

    if (categoryId != null && categoryId.isNotEmpty) {
      queryParams['category_id'] = categoryId;
    }

    if (name != null && name.isNotEmpty) {
      queryParams['name'] = name;
    }
    print('service seach price ${startPrice.toString() == "null"}');
    if (startPrice != 'null' && (startPrice ?? '').isNotEmpty) {
      queryParams['start_price'] = (startPrice ?? '');
    }

    if (endPrice != 'null' && (endPrice ?? '').isNotEmpty) {
      queryParams['end_price'] = (endPrice ?? '');
    }

    if (filter != null && filter.isNotEmpty) {
      queryParams['filter'] = filter;
    }

    if (branchId != null && branchId.isNotEmpty) {
      queryParams['branch_id'] = branchId;
    }

    if (clinicId != null && clinicId.isNotEmpty) {
      queryParams['clinic_id'] = clinicId;
    }

    if (clinicFeatured != null && clinicFeatured.isNotEmpty) {
      queryParams['clinic_featured'] = clinicFeatured;
    }

    if (adminFeatured != null && adminFeatured.isNotEmpty) {
      queryParams['admin_featured'] = adminFeatured;
    }

    if (target != null && target.isNotEmpty) {
      queryParams['target'] = target;
    }

    queryParams['page'] = page!;

    final queryString = Uri(queryParameters: queryParams).query;

    final url = "${ApiConfig.baseUrl}/offers/get?$queryString";

    return await ApiManger().execute(
      url: url,
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getSingleProduct({
    required String id,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/products/single?id=${id}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getSingleOffers({
    required String id,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/offers/single?id=${id}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getListOfferDoctors({
    required String id,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/offers/offer-doctors?id=${id}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getListOfferRates({
    required String id,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/offers/offer-rates?id=${id}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getProductRates({
    required String id,
    required String page,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/products/product-rates?id=${id}&page=$page",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getFavorites({
    required String type,
    required int pageNo,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/favorites/get?type=$type&page=$pageNo",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> addAndDeleteFavorites({
    required String id,
    required String type,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/favorites/favorite",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: {
        "id": "$id",
        "type": "$type",
      },
    );
  }

//
  Future<ResponseModel> getCoupons() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/coupons/get?name&code",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> setCoupons({
    required String message,
    required String amount,
    required String paymentType,
    required String fullName,
    required String phone,
    required String themeId,
  }) async {
    return await ApiManger().execute(
        url: "${ApiConfig.baseUrl}/coupons/save",
        HTTPRequestMethod: HTTPRequestEnum.POST,
        isAuth: true,
        query: {
          "message": message,
          "amount": amount,
          "payment_type": paymentType,
          "full_name": fullName,
          "phone": phone,
          "theme_id": themeId,
        });
  }

  Future<ResponseModel> getCouponsThemes() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/coupons/themes",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> setCouponsRedeem({
    required String code,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/coupons/redeem",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: {
        "code": code,
      },
    );
  }

  Future<ResponseModel> getAppointments({
    required int filter,
    required int page,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/appointments/get-appointments?filter=$filter&page=$page",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getAppointmentsCancelReasons() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/appointments/cancel-reasons",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> orderCancelReasons() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/orders/cancel-reasons",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> cancelOrder({
    required String orderId,
    required List<String> reasondIds,
  }) async {
    // Define the request body
    final Map<String, dynamic> requestBody = {
      "order_id": orderId,
      "cancel_reasons": reasondIds.map((e) => {"id": e.toString()}).toList()
    };

    // Encode the request body as JSON
    final String requestBodyJson = jsonEncode(requestBody);

    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/orders/cancel-order",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: requestBody,
    );
  }

  Future<ResponseModel> cancelAppointment({
    required String appointmentId,
    required List<String> reasondIds,
  }) async {
    // Define the request body
    final Map<String, dynamic> requestBody = {
      "appointment_id": appointmentId,
      "cancel_reasons": reasondIds.map((e) => {"id": e.toString()}).toList()
    };

    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/appointments/cancel-appointment",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: requestBody,
    );
  }

  Future<ResponseModel> googleMapPlace({
    required String searchQuery,
  }) async {
    return await ApiManger().execute(
      url:
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchQuery&key=AIzaSyBiCU45NaS8NgadKJcIfFLY_CUu_IF2E9Y",
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> addToCart({
    required String productId,
    required String quantity,
    required bool isNew,
    String? variantId,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/cart/add-to-cart",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: {
        "product_id": productId,
        "quantity": quantity,
        "variant_id": variantId,
        "is_new": isNew,
      },
    );
  }

  Future<ResponseModel> getCartProducts() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/cart/get-cart",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> deleteProductFromCart({required String productId}) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/cart/delete-from-cart",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: {
        "id": productId,
      },
    );
  }

  Future<ResponseModel> addToGuestCart({
    required String productId,
    required String quantity,
    required bool isNew,
    String? variantId,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/cart/add-to-guest-cart",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "product_id": productId,
        "quantity": quantity,
        "variant_id": variantId,
        "is_new": isNew,
        "guest_token": Get.find<AuthenticationController>().guestToken,
      },
    );
  }

  Future<ResponseModel> getGuestCart() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/cart/get-guest-cart?guest_token=${Get.find<AuthenticationController>().guestToken}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> deleteGuestProductCart({required String productId}) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/cart/delete-from-guest-cart",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "id": productId,
        "guest_token": Get.find<AuthenticationController>().guestToken,
      },
    );
  }

  //Future<ResponseModel> getShippingCompanies({required String addressId}) async {
  Future<ResponseModel> requestOrder({
    required String partnerId,
    required String addressId,
    required String paymentMethod,
    required String marketId,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/orders/request-order",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
      query: {
        "payment_type": paymentMethod,
        "address_id": addressId,
        "partner_id": partnerId,
        "market_id": marketId,
      },
    );
  }

  // Future<ResponseModel> getShippingCompanies({required String addressId}) async {
  //   return await ApiManger().execute(
  //     url: "${ApiConfig.baseUrl}/orders/get-shipping-companies?address_id=$addressId",

  Future<ResponseModel> getShippingCompanies({
    required String addressId,
    required String marketId,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/orders/get-shipping-companies?address_id=$addressId&market_id=$marketId",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getOrders({required int pageNo}) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/orders/get-orders?page=$pageNo",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getOrderDetails({required int orderId}) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/orders/get-order-details?id=$orderId",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> reOrder({required int orderId}) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/orders/re-order",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "order_id": orderId,
      },
      isAuth: true,
    );
  }

  Future<ResponseModel> rateOrderProduct({
    required String orderId,
    required String productId,
    required String rate,
    String? message,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/orders/rate-order-product",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "product_id": productId,
        "order_id": orderId,
        "rate": rate,
        "message": message,
      },
      isAuth: true,
    );
  }

  Future<ResponseModel> rateMarket({
    required String orderId,
    required String marketId,
    required String rate,
    String? message,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/orders/rate-order-market",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "market_id": marketId,
        "order_id": orderId,
        "rate": rate,
        "message": message,
      },
      isAuth: true,
    );
  }

  Future<ResponseModel> rateOffer({
    required String offerId,
    required String appointmentId,
    required String rate,
    String? message,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/appointments/rate-appointment-offer",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "offer_id": offerId,
        "appointment_id": appointmentId,
        "rate": rate,
        "message": message,
      },
      isAuth: true,
    );
  }

  Future<ResponseModel> rateBranch({
    required String branchId,
    required String appointmentId,
    required String rate,
    String? message,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/appointments/rate-appointment-branch",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "branch_id": branchId,
        "appointment_id": appointmentId,
        "rate": rate,
        "message": message,
      },
      isAuth: true,
    );
  }

  Future<ResponseModel> rateDoctor({
    required String doctorId,
    required String appointmentId,
    required String rate,
    String? message,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/appointments/rate-appointment-doctor",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "doctor_id": doctorId,
        "appointment_id": appointmentId,
        "rate": rate,
        "message": message,
      },
      isAuth: true,
    );
  }

  // Future<ResponseModel> getBranches({required int pageNo}) async {
  //   return await ApiManger().execute(
  //     url: "${ApiConfig.baseUrl}/branches/get",
  //     HTTPRequestMethod: HTTPRequestEnum.GET,
  //     isAuth: true,
  //   );
  // }

  Future<ResponseModel> getBranchesSingle({
    required int branchesId,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/branches/single?id=$branchesId",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getOffersByBranchesId({
    required int branchesId,
    required int page,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/offers/get?branch_id=$branchesId&page=$page",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

//  Future<ResponseModel> getOffersByBranchesId({
//     required int branchesId,
//   }) async {
//     return await ApiManger().execute(
//       url: "${ApiConfig.baseUrl}/offers/get?branch_id=$branchesId",
//       HTTPRequestMethod: HTTPRequestEnum.GET,
//       isAuth: true,
//     );
//   }

  Future<ResponseModel> getOffersService() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/offers/get?admin_featured=1",
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> getOffersProduct() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/products/get?admin_featured=1",
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> updateAppointment({
    required String appointmentID,
    required String dateTime,
    required String time,
    required String notes,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/appointments/update-appointment",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "appointment_id": appointmentID,
        "date_time": dateTime,
        "time": time,
        "notes": notes,
      },
      isAuth: true,
    );
  }

  Future<ResponseModel> getMarket({
    required int page,
    String? categoryId,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/products/markets?page=$page&category_id=${categoryId == null ? "" : categoryId}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> getCategoriesByMarketId({
    required String marketId,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/products/categories?market_id=$marketId",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getHomesSliderSetting() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/setting/slider?type=home",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getHomeSection() async {
    return await ApiManger().execute(
      url: "${ApiConfig.baseUrl}/setting/sections",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  // Future<ResponseModel> getMarketByCategoryID({required String categoryId}) async {
  //   return await ApiManger().execute(
  //     url: "${ApiConfig.baseUrl}/products/markets?category_id=${categoryId}",
  //     HTTPRequestMethod: HTTPRequestEnum.GET,
  //   );
  // }
}
