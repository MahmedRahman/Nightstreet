import 'dart:async';

import 'package:get/get.dart';

class VerifyPhoneController extends GetxController {
  Timer? _timer;
  int remainingSeconds = 1;
  var time = '00.00'.obs;

  @override
  void onInit() {
    time = '00.00'.obs;
    startTimer(30);
    super.onInit();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        time.value = '00.00';
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainingSeconds--;
      }
    });
  }
}
