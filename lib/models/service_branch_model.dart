class ServiceBranchModel {
  int id;
  String name;
  String cityName;
  String address;

  ServiceBranchModel({
    required this.id,
    required this.name,
    required this.cityName,
    required this.address,
  });

  factory ServiceBranchModel.fromJson(Map<String, dynamic> json) {
    return ServiceBranchModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      cityName: json['city']['name'],
    );
  }
}
