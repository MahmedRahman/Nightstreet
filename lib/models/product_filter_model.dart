import 'package:equatable/equatable.dart';

class ProductFilterModel extends Equatable {
  ProductFilterModel({required this.searchKey, required this.title});

  final String title;
  final String searchKey;

  @override
  List<Object> get props => [searchKey, title];
}

List<ProductFilterModel> get productFilterItems => [
      ProductFilterModel(searchKey: '', title: 'الكل'),
      ProductFilterModel(searchKey: '1', title: "الاعلى تقييماً"),
      ProductFilterModel(searchKey: '4', title: "الأكــثر مبيعاً"),
      ProductFilterModel(searchKey: '3', title: "السعر الاعلى"),
      ProductFilterModel(searchKey: '2', title: "السعر الادنى"),
    ];
