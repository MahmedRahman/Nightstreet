import 'package:get/get.dart';
import 'package:krzv2/models/appointment_model.dart';
import 'package:krzv2/web_serives/model/api_response_model.dart';
import 'package:krzv2/web_serives/web_serives.dart';

class AppointmentMangmentController extends GetxController
    with ScrollMixin, StateMixin<List<AppointmentModel>> {
  final List<AppointmentModel> _appointments = [];

  int currentPage = 1;
  bool? isPagination;
  RxInt rxAppointmentType = 1.obs;

  @override
  void onInit() async {
    change([], status: RxStatus.loading());
    await fetchAppointments();
    super.onInit();
  }

  fetchAppointments() async {
    final ResponseModel responseModel = await WebServices().getAppointments(
      filter: rxAppointmentType.value,
      page: currentPage,
    );

    try {
      if (responseModel.data['success'] == true) {
        final fetchedAppointments = List<AppointmentModel>.from(
          responseModel.data['data']['data']
              .map((item) => AppointmentModel.fromJson(item)),
        );

        _appointments.addAll(fetchedAppointments);

        if (_appointments.isEmpty) {
          change([], status: RxStatus.empty());
          return;
        }

        await Future.delayed(const Duration(milliseconds: 500));
        change(_appointments, status: RxStatus.success());

        isPagination =
            responseModel.data['data']['pagination']['is_pagination'] as bool;
      }
    } catch (e) {}
  }

  void fetchAppointmentByType(int appointmentType) {
    _appointments.clear();
    currentPage = 1;
    rxAppointmentType.value = appointmentType;
    fetchAppointments();
  }

  @override
  Future<void> onEndScroll() async {
    if (isPagination == false) return;
    currentPage++;

    change(_appointments, status: RxStatus.loadingMore());

    await fetchAppointments();
  }

  @override
  Future<void> onTopScroll() async {
    print('onTopScroll');
  }
}
