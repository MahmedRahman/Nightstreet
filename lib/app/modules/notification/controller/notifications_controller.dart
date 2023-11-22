import 'package:get/get.dart';
import 'package:krzv2/app/modules/notification/model/notification_model.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';
import 'package:krzv2/services/auth_service.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class NotificationController extends GetxController
    with StateMixin<List<NotificationModel>>, ScrollMixin {
  final List<NotificationModel> _notifications = [];
  int currentPage = 1;

  bool? isPagination;

  @override
  void onInit() async {
    change([], status: RxStatus.loading());
    await fetchNotifications();
    super.onInit();
  }

  fetchNotifications() async {
    final ResponseModel responseModel = await WebServices().fetchNotifications(
      page: currentPage,
    );

    if (responseModel.data['success'] == true) {
      final fetchedNotifications = List<NotificationModel>.from(
        responseModel.data['data']['data']
            .map((item) => NotificationModel.fromJson(item)),
      );

      _notifications.addAll(fetchedNotifications);

      if (_notifications.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      await Future.delayed(const Duration(milliseconds: 500));
      change(_notifications, status: RxStatus.success());

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
    }
  }

  readNotifications(int id) async {
    final ResponseModel responseModel = await WebServices().readNotifications(
      id: id,
    );

    if (responseModel.data['success'] == true) {
      //AppDialogs.showToast(message: responseModel.data['message']);
      _notifications.clear();
      fetchNotifications();
      Get.find<AuthenticationController>().getProfile();
      return;
    }

    AppDialogs.showToast(message: responseModel.data['message']);
    return;
  }

  readAllNotifications() async {
    final ResponseModel responseModel =
        await WebServices().readAllNotifications();

    if (responseModel.data['success'] == true) {
      _notifications.clear();
      fetchNotifications();
      Get.find<AuthenticationController>().getProfile();
      return;
    }

    AppDialogs.showToast(message: responseModel.data['message']);
    return;
  }

  @override
  Future<void> onEndScroll() async {
    if (isPagination == false) return;

    currentPage++;

    change(_notifications, status: RxStatus.loadingMore());

    await fetchNotifications();
  }

  @override
  Future<void> onTopScroll() async {}

  String getRelativeTimeString(DateTime providedDateTime) {
    DateTime now = DateTime.now();

    Duration difference = now.difference(providedDateTime);
    int daysDifference = difference.inDays;

    switch (daysDifference) {
      case 0:
        return "اليوم";
      case 1:
        return "منذ يوم";
      case 2:
        return "منذ يومين";
      default:
        return "منذ $daysDifference أيام";
    }
  }
}
