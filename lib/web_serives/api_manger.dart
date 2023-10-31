// import 'dart:developer';

// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/request/request.dart';
// import 'package:krzv2/routes/app_pages.dart';
// import 'package:krzv2/services/auth_service.dart';
// import 'package:krzv2/services/internet_connection.dart';
// import 'package:logger/logger.dart';

// import 'api_response_model.dart';

// enum HTTPRequestEnum {
//   GET,
//   POST,
//   DELETE,
// }

// class ApiManger extends GetConnect {
//   var logger = Logger(
//     printer: PrettyPrinter(
//       methodCount: 2, // number of method calls to be displayed
//       errorMethodCount: 8, // number of method calls if stacktrace is provided
//       lineLength: 80, // width of the output
//       colors: true, // Colorful log messages
//       printEmojis: true, // Print an emoji for each log message
//       printTime: true, // Should each log print contain a timestamp
//     ),
//   );

//   @override
//   void onInit() {
//     httpClient.defaultContentType = "application/json";
//     httpClient.timeout = const Duration(seconds: 8);

//     httpClient.addRequestModifier((Request request) {
//       request.headers.addAll({'lang': 'ar'});
//       return request;
//     });
//   }

//   Future<ResponseModel> execute({
//     required String url,
//     required HTTPRequestEnum HTTPRequestMethod,
//     dynamic query,
//     bool? isAuth = false,
//   }) async {
//     final internetCheckerService = InternetConnectionService();

//     if (await internetCheckerService.checkConnection() == false) {
//       return ResponseModel(
//         status: false,
//         statusCode: 600,
//         message: '',
//         data: {
//           'success': false,
//           "message": "الرجاء التحقق من اتصال الإنترنت الخاص بك.",
//         },
//       );
//     }

//     httpClient.addRequestModifier((Request request) {
//       request.headers.addAll({'lang': 'ar'});
//       return request;
//     });
//     Response response;

//     final authService = Get.find<AuthenticationController>();
//     print(authService.token);
//     if (isAuth! == true) {
//       var headers = {
//         'Authorization': "Bearer ${authService.token}",
//         'Accept': 'application/json',
//       };

//       httpClient.addAuthenticator((Request request) async {
//         request.headers.addAll(headers);
//         return request;
//       });
//     }

//     if (HTTPRequestMethod != HTTPRequestEnum.POST) {
//       logger.t("Send Request : $url ");
//     }

//     if (HTTPRequestMethod == HTTPRequestEnum.POST) {
//       logger.t("Send Request : $url $query ");
//     }

//     log(
//       """\x1B[33mRequest
// Method ${HTTPRequestMethod.name.toString()}
// URl $url
// ${(query != null) ? "api Query : $query" : ""}\x1B[0m """,
//       name: "API",
//     );

//     switch (HTTPRequestMethod) {
//       case HTTPRequestEnum.GET:
//         response = await get(
//           url,
//           headers: {
//             'Authorization': "Bearer ${authService.token}",
//             'Accept': 'application/json',
//           },
//         );
//         break;
//       case HTTPRequestEnum.POST:
//         response = await post(
//           url,
//           query,
//           headers: {
//             'Authorization': "Bearer ${authService.token}",
//             'Accept': 'application/json',
//           },
//         );
//         break;
//       case HTTPRequestEnum.DELETE:
//         response = await delete(url);
//         break;
//       default:
//         response = await get(url);
//     }
//     ResponseModel responseModel;

//     log(
//       """\x1B[32mResponse Code  ${response.statusCode}
// Method   ${HTTPRequestMethod.name.toString()}
// URl $url
// header ${response.body}
//       \x1B[0m""",
//       name: "response",
//     );

//     if (response.statusCode == 200) {
//       logger.t("URL : $url \nStatusCode : ${response.statusCode} ");
//       logger.t(response.body);
//     }

//     if (response.statusCode == 200) {
//       responseModel = ResponseModel(
//         status: true,
//         statusCode: 200,
//         message: "Success",
//         data: response.body,
//       );
//       return responseModel;
//     }

//     if (response.statusCode == 401) {
//       Get.toNamed(Routes.LOGIN);
//       responseModel = ResponseModel(
//         status: true,
//         statusCode: 401,
//         message: "Success",
//         data: response.body,
//       );
//       return responseModel;
//     }

//     responseModel = ResponseModel(
//       status: false,
//       statusCode: response.statusCode ?? 404,
//       message: errorHandler(response),
//       data: {
//         'success': false,
//         "message": "حدث خطأ ما",
//       },
//     );

//     logger.e(
//         "Response : $url ${response.statusCode ?? 404} ${errorHandler(response)} ");

//     return responseModel;
//   }

//   String errorHandler(Response? response) {
//     log(response!.bodyString.toString());
//     switch (response.statusCode) {
//       case 500:
//         return "Server Error pls retry later";
//       case 403:
//         return 'Error occurred pls check internet and retry.';
//       default:
//         return 'Error occurred retry';
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/api_response_model.dart';
import 'package:krzv2/web_serives/network_error_page.dart';
import 'package:logger/logger.dart';

class ApiConfig {
  static const bool KShowLog = true;
  static const bool KShowError = true;
  Function KLoginPage = () {
    return Get.offAndToNamed(Routes.LOGIN);
  };

  // Function KNetworkErrorPage = () {
  //   return Get.to(NetworkErrorPage());
  // };
}

bool KShowLog = true;
bool KShowError = true;

enum HTTPRequestEnum { GET, POST }

class ApiManger extends GetConnect {
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
  var logger = Logger();

  // @override
  // void onInit() {
  //   httpClient.defaultContentType = "application/json";
  //   httpClient.timeout = Duration(seconds: 50);

  //   httpClient.addRequestModifier((Request request) {
  //     request.headers.addAll({
  //       'lang': 'ar',
  //       'Accept': 'application/json',
  //     });
  //     return request;
  //   });
  // }

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

    ResponseModel responseModel = getResponseModel(response!);

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
    // ApiConfig().KNetworkErrorPage;
    return responseModel;
  }

  ResponseModel getResponseModel(Response response) {
    ResponseModel responseModel;

    if (response.statusCode == 200) {
      responseModel = ResponseModel(
        url: response.request!.url.toString(),
        status: true,
        statusCode: 200,
        message: "Success",
        data: response.body,
        query: query.toString(),
      );
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
          query: query.toString());

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
        query: query.toString());

    return responseModel;
  }
}
