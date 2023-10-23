import 'package:equatable/equatable.dart';

class ProductFilterModel extends Equatable {
  ProductFilterModel({required this.searchKey, required this.title});

  final String title;
  final String searchKey;

  @override
  List<Object> get props => [searchKey, title];
}

List<ProductFilterModel> get productFilterItems => [
      ProductFilterModel(searchKey: 'latest', title: 'الكل'),
      ProductFilterModel(searchKey: 'offers', title: "الاعلى تقييماً"),
      ProductFilterModel(searchKey: 'most_sellers', title: "الأكــثر مبيعاً"),
      ProductFilterModel(searchKey: 'high_price', title: "السعر الاعلى"),
      ProductFilterModel(searchKey: 'lowest_price', title: "السعر الادنى"),
    ];
