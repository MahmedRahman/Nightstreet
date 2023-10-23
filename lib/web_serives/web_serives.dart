import 'dart:io';

import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:krzv2/models/branch_url_model.dart';
import 'package:krzv2/web_serives/api_constant.dart';
import 'package:krzv2/web_serives/api_manger.dart';
import 'package:krzv2/web_serives/api_response_model.dart';

class WebServices {
  //final ApiClient apiclient;
  //this.apiclient
  WebServices();
  Future<ResponseModel> getSetting() async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/setting/get-setting",
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> getAppVersion() async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/setting/app-version",
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> authLogin({
    required String phone,
    required String code,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/auth/login",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "phone": phone,
        "code": code,
      },
    );
  }

  Future<ResponseModel> updatePhone({
    required String phone,
    required String code,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/auth/update-phone",
      HTTPRequestMethod: HTTPRequestEnum.POST,
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
      url: "${ApiConstant.baseUrl}/auth/client-register",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "name": name,
        "email": email,
        "phone": phone,
        "firebas_token": firebasToken,
      },
    );
  }

  Future<ResponseModel> authSendOtp({
    required String phone,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/auth/send-otp",
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
      url: "${ApiConstant.baseUrl}/auth/send-otp-update-phone",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "phone": phone,
      },
    );
  }

  Future<ResponseModel> getAuthProfile() async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/auth/profile",
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
      url: "${ApiConstant.baseUrl}/auth/update-profile",
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
      url: "${ApiConstant.baseUrl}/auth/change-password",
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
      url: "${ApiConstant.baseUrl}/auth/logout",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
    );
  }

  Future<ResponseModel> authNewGuest({
    required String firebasToken,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/auth/new-guest",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "firebas_token": firebasToken,
      },
    );
  }

  Future<ResponseModel> deleteAccount() async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/auth/delete-account",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
    );
  }

  Future<ResponseModel> fetchNotifications({
    required int page,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/notifications/get?page=$page",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getComplaintsCategories() async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/complaints/categories",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getComplaints({
    required int filter,
    required int page,
  }) async {
    return await ApiManger().execute(
      url:
          "${ApiConstant.baseUrl}/complaints/get?page&filter=${filter.toString()}&page=$page",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getComplaintsDetails({
    required String complaintID,
  }) async {
    return await ApiManger().execute(
      url:
          "${ApiConstant.baseUrl}/complaints/get-chats?complaint_id=${complaintID.toString()}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> setComplaints({
    required String message,
    required String complaintID,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/complaints/store-chat",
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
      url: "${ApiConstant.baseUrl}/coupons/redeem",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      query: {
        "code": code,
      },
      isAuth: true,
    );
  }

  Future<ResponseModel> getTransactions({required int pageNo}) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/wallet/get-transactions?page=$pageNo",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getNotifications() async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/notifications/get",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> readAllNotifications() async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/notifications/read-all",
      HTTPRequestMethod: HTTPRequestEnum.POST,
      isAuth: true,
    );
  }

  Future<ResponseModel> getCities() async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/setting/cities",
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> getCategories({
    required String name,
    required String category_id,
  }) async {
    return await ApiManger().execute(
      url:
          "${ApiConstant.baseUrl}/complaints/categories?name={$name}&category_id={$category_id}",
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
    } catch (e, st) {
      print("error $e");
      print("stack $st");
    }

    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/complaints/store",
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
      url: "${ApiConstant.baseUrl}/setting/slider?type=$type",
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> getAddresses() async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/addresses/get?is_default=1",
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
      url: "${ApiConstant.baseUrl}/addresses/save",
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
    required String cityId,
    required String phone,
    required String address,
    required String email,
    required String name,
    required String notes,
    required String isDefault,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/addresses/update",
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

  Future<ResponseModel> activationAddresses({
    required String id,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/addresses/activation",
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
      url:
          "${ApiConstant.baseUrl}/products/categories?name=${name}&category_id=${categoryId}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getServicesCategories({
    String? name = "",
    String? categoryId = "",
  }) async {
    return await ApiManger().execute(
      url:
          "${ApiConstant.baseUrl}/offers/categories?name=${name}&category_id=${categoryId}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getProductsBrands({
    required String name,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/products/brands?name=${name}",
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
        ApiConstant.baseUrl,
        page,
        queryParams: queryParameters,
      ),
      HTTPRequestMethod: HTTPRequestEnum.GET,
    );
  }

  Future<ResponseModel> getProducts({
    String? name = '',
    String? categoryId = '',
    String? startPrice = '',
    String? endPrice = '',
    String? filter = '',
    String? brandIds = '',
    String? limit = '',
    String? adminFeatured = '',
  }) async {
    return await ApiManger().execute(
      url:
          "${ApiConstant.baseUrl}/products/get?category_id=$categoryId&name=$name&start_price=$startPrice&end_price=$endPrice&filter=${filter}&brand_ids=$brandIds&limit=${limit}&admin_featured=$adminFeatured",
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

    if (startPrice != null && startPrice.isNotEmpty) {
      queryParams['start_price'] = startPrice;
    }

    if (endPrice != null && endPrice.isNotEmpty) {
      queryParams['end_price'] = endPrice;
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

    final url = "${ApiConstant.baseUrl}/offers/get?$queryString";

    print('url => $url');

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
      url: "${ApiConstant.baseUrl}/products/single?id=${id}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getSingleOffers({
    required String id,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/offers/single?id=${id}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getListOfferDoctors({
    required String id,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/offers/offer-doctors?id=${id}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getListOfferRates({
    required String id,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/offers/offer-rates?id=${id}",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getProductRates({
    required String id,
    required String page,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/products/product-rates?id=${id}&page=$page",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getFavorites({
    required String type,
    required int pageNo,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/favorites/get?type=$type&page=$pageNo",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> addAndDeleteFavorites({
    required String id,
    required String type,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/favorites/favorite",
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
      url: "${ApiConstant.baseUrl}/coupons/get?name&code",
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
        url: "${ApiConstant.baseUrl}/coupons/save",
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
      url: "${ApiConstant.baseUrl}/coupons/themes",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> setCouponsRedeem({
    required String code,
  }) async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/coupons/redeem",
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
      url:
          "${ApiConstant.baseUrl}/appointments/get-appointments?filter=$filter&page=$page",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
    );
  }

  Future<ResponseModel> getAppointmentsCancelReasons() async {
    return await ApiManger().execute(
      url: "${ApiConstant.baseUrl}/appointments/cancel-reasons",
      HTTPRequestMethod: HTTPRequestEnum.GET,
      isAuth: true,
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
}
