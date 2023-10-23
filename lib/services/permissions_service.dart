import 'package:permission_handler/permission_handler.dart';

abstract class PermissionsHelper {
  static Future<PermissionStatus> requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;
    if (status.isDenied) {
      // You don't have permission yet. Request it.
      status = await Permission.notification.request();
      if (status == PermissionStatus.permanentlyDenied) {
        return status;
      }
      return requestNotificationPermission();
    }
    // The user denied permission with the "never ask again" option.
    // You should show a dialog explaining how to enable permission manually.
    return status;
  }

  static Future<PermissionStatus> requestLocationPermission() async {
    final status = await Permission.location.status;
    if (status.isDenied) {
      print('star per');
      // You don't have permission yet. Request it.
      await Permission.location.request();
      return requestLocationPermission();
    }

    // The user denied permission with the "never ask again" option.
    // You should show a dialog explaining how to enable permission manually.
    return status;
  }
}
