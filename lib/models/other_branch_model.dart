class OtherBranchModel {
  final int id;
  final String name;
  final String address;
  final bool current;

  OtherBranchModel({
    required this.id,
    required this.name,
    required this.address,
    required this.current,
  });

  factory OtherBranchModel.fromJson(Map<String, dynamic> json) {
    return OtherBranchModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      current: json['current'],
    );
  }
}
