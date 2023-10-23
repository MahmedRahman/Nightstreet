import 'package:krzv2/models/service_branch_model.dart';
import 'package:krzv2/models/service_clinic_model.dart';

class ServiceModel {
  int id;
  int? adminfeatured;
  String name;
  String desc;
  String target;
  String? instructions;
  String? device;
  String? subject;
  String image;
  double? oldPrice;
  double price;
  double amountToPay;
  String? cashback;
  ServiceClinicModel clinic;
  List<ServiceBranchModel> branches;
  List<String> images;
  double totalRateAvg;
  int totalRateCount;
  bool isFavorite;
  int active;

  ServiceModel({
    required this.id,
    required this.adminfeatured,
    required this.name,
    required this.desc,
    required this.target,
    required this.image,
    required this.price,
    required this.amountToPay,
    required this.cashback,
    required this.clinic,
    required this.branches,
    required this.images,
    required this.totalRateAvg,
    required this.totalRateCount,
    required this.isFavorite,
    required this.active,
    this.instructions,
    this.device,
    this.subject,
    this.oldPrice,
  });

  static ServiceModel dummyService = ServiceModel(
    id: 1,
    adminfeatured: 1,
    name: "Sample Service",
    desc: "This is a sample service description.",
    target: "Sample target",
    instructions: "Sample instructions for the service",
    device: "Sample device information",
    subject: "Sample subject",
    image: "sample_image.jpg",
    oldPrice: 24.99,
    price: 19.99,
    amountToPay: 19.99,
    cashback: "5% cashback on this service",
    clinic: ServiceClinicModel(
        id: 1,
        name: 'sample clinic',
        image: ''), // Create a dummy ServiceClinicModel object
    branches: [
      ServiceBranchModel(
        id: 1,
        name: 'sample brand name',
        cityName: 'brand city',
        address: 'brand address',
      )
    ], // Create a dummy list of ServiceBranchModel
    images: [
      "image1.jpg",
      "image2.jpg",
      "image3.jpg"
    ], // Create a list of image URLs
    totalRateAvg: 4.5,
    totalRateCount: 1000,
    isFavorite: false,
    active: 1,
  );

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    var branchList = json['branches'] as List;
    var imageList = json['images'] as List;

    return ServiceModel(
      id: json['id'],
      adminfeatured: json['admin_featured'],
      name: json['name'],
      desc: json['desc'] ?? '',
      target: json['target'],
      instructions: json['instructions'],
      device: json['device'],
      subject: json['subject'],
      image: json['image'],
      oldPrice: json['old_price'].toDouble(),
      price: json['price'].toDouble(),
      amountToPay: json['amount_to_pay'].toDouble(),
      cashback: json['cashback'],
      clinic: ServiceClinicModel.fromJson(json['clinic']),
      branches:
          branchList.map((item) => ServiceBranchModel.fromJson(item)).toList(),
      images: List<String>.from(
        imageList.map((image) => image['image']),
      ),
      totalRateAvg: json['total_rate_avg'].toDouble(),
      totalRateCount: json['total_rate_count'],
      isFavorite: json['is_favorite'],
      active: json['active'],
    );
  }
}
