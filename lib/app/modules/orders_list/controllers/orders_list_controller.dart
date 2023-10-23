import 'package:get/get.dart';

class OrdersListController extends GetxController
    with StateMixin<List<dynamic>> {
  List orders = [
    {
      "orderNo": '58967895',
      "orderDate": 'الإثنـــين، 10 اكتوبر 2022م',
      "status": 'تم التوصيل',
      "productCount": '5',
      "price": '1760',
    },
    {
      "orderNo": '58967895',
      "orderDate": 'الإثنـــين، 10 اكتوبر 2022م',
      "status": "قيد التوصيل",
      "productCount": '5',
      "price": '1760',
    },
    {
      "orderNo": '58967895',
      "orderDate": 'الإثنـــين، 10 اكتوبر 2022م',
      "status": "ملغى",
      "productCount": '5',
      "price": '1760',
    },
  ];
  final count = 0.obs;
  @override
  void onInit() {
    change(orders, status: RxStatus.success());
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
