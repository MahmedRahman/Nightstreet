import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/view/network_error_page.dart';
import 'package:logger/logger.dart';

class ApiConfig {
  static String baseUrl = "https://app-krz.tasksa.dev/api";
  // static String baseUrl = "https://api-v2.krz.sa/api";
  static const bool KShowLog = true;
  static const bool KShowError = true;
  static const bool KDebugFlg = true;
  Function KLoginPage = () {
    return Get.offAndToNamed(Routes.LOGIN);
  };
}

RxList ResponseModelList = [].obs;
bool KShowLog = true;
bool KShowError = true;

enum HTTPRequestEnum { GET, POST }

class ApiManger extends GetConnect {
  var logger = Logger();

  ApiManger() {
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = Duration(seconds: 50);

    httpClient.addRequestModifier((Request request) {
      request.headers.addAll({
        'lang': 'ar',
        'Accept': 'application/json',
      });
      return request;
    });
  }

  Future<ResponseModel> execute({
    required String url,
    required HTTPRequestEnum HTTPRequestMethod,
    dynamic query,
    bool isAuth = false,
  }) async {
    if (ApiConfig.KShowLog) logger.wtf("""
    Send Request : ${url} 
    query : ${query} 
    """);

    httpClient.addRequestModifier((Request request) {
      request.headers.addAll(
        {
          'lang': 'ar',
          'Accept': 'application/json',
        },
      );
      if (isAuth) {
        request.headers.addAll(
          {
            'Authorization':
                "Bearer ${Get.find<AuthenticationController>().token}",
          },
        );
      }
      return request;
    });

    Response? response;

    if (HTTPRequestMethod == HTTPRequestEnum.GET) {
      response = await get(url);
    }

    if (HTTPRequestMethod == HTTPRequestEnum.POST) {
      response = await post(url, query);
    }

    ResponseModel responseModel =
        getResponseModel(response!, query, HTTPRequestMethod);
    ResponseModelList.add(responseModel);
    ResponseModelList.value = ResponseModelList.reversed.toList();
    if (ApiConfig.KShowLog) logger.e("""
      URL : ${response.request!.url.toString()} 
      StatusCode : ${responseModel.statusCode} 
      body:${responseModel.data}
      """);

    if (responseModel.statusCode == 200) {
      return responseModel;
    }

    if (responseModel.statusCode == 401) {
      Get.offAndToNamed(Routes.LOGIN);
      return responseModel;
    }

    Get.to(NetworkErrorPage(responseModel));

    return responseModel;
  }

  ResponseModel getResponseModel(Response response, query, hTTPRequest) {
    ResponseModel responseModel;

    if (response.statusCode == 200) {
      responseModel = ResponseModel(
          url: response.request!.url.toString(),
          status: true,
          statusCode: 200,
          message: "Success",
          data: response.body,
          query: query.toString(),
          httpRequest: hTTPRequest);
      return responseModel;
    }

    if (response.statusCode == 401) {
      if (KShowError)
        logger.wtf(
            "URL : ${response.request!.url.toString()} \nStatusCode : ${response.statusCode} ");

      responseModel = ResponseModel(
          url: response.request!.url.toString(),
          status: false,
          statusCode: 401,
          message: response.statusText,
          data: null,
          query: query.toString(),
          httpRequest: hTTPRequest);

      return responseModel;
    }

    if (KShowError)
      logger.wtf(
          "URL : ${response.request!.url.toString()} \nStatusCode : ${response.statusCode} ");

    responseModel = ResponseModel(
        url: response.request!.url.toString(),
        status: false,
        statusCode: response.statusCode!,
        message: response.statusText,
        data: null,
        query: query.toString(),
        httpRequest: hTTPRequest);

    return responseModel;
  }
}
