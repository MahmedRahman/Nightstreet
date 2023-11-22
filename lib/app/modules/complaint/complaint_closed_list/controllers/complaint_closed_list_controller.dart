import 'package:get/get.dart';
import 'package:krzv2/models/complaint_model.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class ComplaintClosedListController extends GetxController
    with StateMixin<List<ComplaintModel>>, ScrollMixin {
  final List<ComplaintModel> _activeComplaints = [];
  int currentPage = 1;
  bool? isPagination;
  @override
  void onInit() {
    super.onInit();
    getComplaints();
  }

  resetPaginationData() {
    currentPage = 1;
    _activeComplaints.clear();
    update();
  }

  void getComplaints() async {
    if (currentPage == 1) {
      change([], status: RxStatus.loading());
      _activeComplaints.clear();
    }
    ResponseModel responseModel = await WebServices().getComplaints(
      filter: 2,
      page: currentPage,
    );

    if (responseModel.data["success"]) {
      final List<ComplaintModel> serviceDataList = List<ComplaintModel>.from(
        responseModel.data['data']['data']
            .map((category) => ComplaintModel.fromJson(category)),
      );

      _activeComplaints.addAll(serviceDataList);

      if (_activeComplaints.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }

      change(_activeComplaints, status: RxStatus.success());

      isPagination =
          responseModel.data['data']['pagination']['is_pagination'] as bool;
    }

    if (responseModel.data["success"] == false) {
      change([], status: RxStatus.error(responseModel.data["message"]));
      return;
    }
  }

  @override
  Future<void> onEndScroll() async {
    if (isPagination == false) return;
    currentPage++;

    change(_activeComplaints, status: RxStatus.loadingMore());
    getComplaints();
  }

  @override
  Future<void> onTopScroll() async {
    print('onTopScroll');
  }
}
