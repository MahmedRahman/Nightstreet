import 'dart:developer';

import 'package:get/get.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';
import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionService extends GetxService {
  PackageInfo? packageInfo;
  var _appVersionCloudData = {};
  PlateForm get _getPlateForm =>
      Platform.isAndroid ? PlateForm.android : PlateForm.ios;
  var _getDeviceVersionName = "0";
  String get _getDeviceBuildNumber => packageInfo!.buildNumber.toString();

  @override
  void onInit() async {
    await _getAppVersion();
    packageInfo = await PackageInfo.fromPlatform();

    _getDeviceVersionName = packageInfo!.version.toString();
    log("AppVersion 00 $_getDeviceVersionName");
    super.onInit();
  }

  Future _getAppVersion() async {
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

  bool showUpdateDialog() {
    bool isForceUpdate = _hasForceUpdate(plateForm: _getPlateForm);

    if (isForceUpdate) {
      if (_getPlateForm == PlateForm.ios) {
        if ((_appVersionCloudData["ios_version_name"] !=
                _getDeviceVersionName) &&
            (_appVersionCloudData["ios_build_number"] !=
                _getDeviceBuildNumber)) {
          return true;
        }
      }

      if (_getPlateForm == PlateForm.android) {
        if ((_appVersionCloudData["android_version_name"] !=
                _getDeviceVersionName) &&
            (_appVersionCloudData["android_build_number"] !=
                _getDeviceBuildNumber)) {
          return true;
        }
      }
    }

    log("AppVersion : ${_getDeviceVersionName.toString()}");

    // log("AppVersion : ${_getDeviceBuildNumber.toString()}");

    log("AppVersion : ${_getPlateForm.toString()}");

    // log("AppVersion : ${_appVersionCloudData["android_version_name"]}");
    // log("AppVersion : ${_appVersionCloudData["android_build_number"]}");

    return false;
  }
}

enum PlateForm {
  android,
  ios,
}
