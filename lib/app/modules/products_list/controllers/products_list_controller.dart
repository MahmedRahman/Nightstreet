import 'package:get/get.dart';

class ProductsListController extends GetxController with StateMixin {
  final List<String> categories = [
    "جميع المنتجات",
    "الوجه",
    "الشفاة",
    "العيون",
    "الحواجب",
    "الخدود",
  ];

  final count = 0.obs;
  @override
  void onInit() {
    change([], status: RxStatus.success());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
