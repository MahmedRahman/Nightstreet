import 'package:krzv2/models/other_branch_model.dart';
import 'package:krzv2/models/product_category_model.dart';
import 'package:krzv2/models/service_clinic_model.dart';

class BranchModel {
  int id;
  String name;
  String cityName;
  ServiceClinicModel clinic;
  String distance;
  String address;
  String clinicImage;

  double lat;
  double lng;
  List<ProductCategory> categories;
  List<OtherBranchModel>? otherBranches;
  double totalRateAvg;
  int totalRateCount;
  bool isFavorite;

  BranchModel({
    required this.id,
    required this.name,
    required this.cityName,
    required this.clinic,
    required this.clinicImage,
    required this.distance,
    required this.address,
    required this.lat,
    required this.lng,
    required this.categories,
    this.otherBranches,
    required this.totalRateAvg,
    required this.totalRateCount,
    required this.isFavorite,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    var categoryList = json['categories'] as List;
    List<ProductCategory> categoryData = categoryList.map((i) => ProductCategory.fromJson(i)).toList();

    var otherBranchesList = json['other_branches'];
    List<OtherBranchModel> otherBranchesData;
    if (otherBranchesList != null) {
      otherBranchesData = (otherBranchesList as List).map((i) => OtherBranchModel.fromJson(i)).toList();
    } else {
      otherBranchesData = [];
    }

    return BranchModel(
      id: json['id'],
      name: json['name'],
      cityName: json['city']['name'],
      clinic: ServiceClinicModel.fromJson(json['clinic']),
      distance: json['distance'],
      address: json['address'],
      clinicImage: json["clinic"]["banner"].toString(),
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
      categories: categoryData,
      otherBranches: otherBranchesData,
      totalRateAvg: double.parse(json['total_rate_avg'].toString()),
      totalRateCount: json['total_rate_count'],
      isFavorite: json['is_favorite'],
    );
  }
}
