import 'package:get/get.dart';

import '../controllers/account_menu_controller.dart';

class AccountMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountMenuController>(
      () => AccountMenuController(),
    );
  }
}
