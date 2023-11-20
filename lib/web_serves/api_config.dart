import 'package:app_night_street/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ApiConfig {
  static String baseUrl = "https://app-krz.tasksa.dev/api";
  static const bool KShowLog = true;
  static const bool KShowError = true;
  static const bool KDebugFlg = false;
  Function KLoginPage = () {
    return Get.offAndToNamed(Routes.LOGIN);
  };
}
