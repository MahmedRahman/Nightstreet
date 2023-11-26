import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_cli/functions/version/version_update.dart';
import 'package:krzv2/utils/app_force_update_dialog.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';
import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionService extends GetxService {
  PackageInfo? packageInfo;
  var _appVersionCloudData = {};
  PlateForm get _getPlateForm =>
      Platform.isAndroid ? PlateForm.android : PlateForm.ios;

  @override
  void onInit() async {
    await getAppVersion();

    super.onInit();
  }

  Future<String> getVersionInfo() async {
    packageInfo = await PackageInfo.fromPlatform();

    return packageInfo!.version.toString();
  }

  Future<String> getBuildDevice() async {
    packageInfo = await PackageInfo.fromPlatform();

    return packageInfo!.buildNumber.toString();
  }

  Future getAppVersion() async {
    ResponseModel response = await WebServices().getAppVersion();
    if (response.data["success"]) {
      _appVersionCloudData = response.data["data"];
    }
  }

  bool _hasForceUpdate({required PlateForm plateForm}) {
    if (_getPlateForm == PlateForm.ios) {
      return (_appVersionCloudData["ios_force_update"] == 1);
    }

    if (_getPlateForm == PlateForm.android) {
      return (_appVersionCloudData["ios_version_name"] == 1);
    }
    return false;
  }

  Future<bool> showUpdateDialog() async {
    bool isForceUpdate = _hasForceUpdate(plateForm: _getPlateForm);
    final String localVerion = await getVersionInfo();
    final String localBuild = await getBuildDevice();

    int compareVersionResult =
        _appVersionCloudData["ios_version_name"].compareTo(localVerion);

    if (isForceUpdate) {
      /// IOS
      if (_getPlateForm == PlateForm.ios) {
        if (compareVersionResult == 0) {
          if (int.parse(_appVersionCloudData["ios_build_number"]) >
              int.parse(localBuild)) {
            return true;
          }
          return false;
        }

        if (compareVersionResult == 1) {
          return true;
        }
      }

      /// ANDROID
      if (_getPlateForm == PlateForm.android) {
        if (compareVersionResult == 0) {
          if (int.parse(_appVersionCloudData["android_build_number"]) >
              int.parse(localBuild)) {
            return true;
          }
          return false;
        }

        if (compareVersionResult == 1) {
          return true;
        }
      }
    }

    return false;
  }
}

enum PlateForm {
  android,
  ios,
}
