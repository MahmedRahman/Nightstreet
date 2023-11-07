class ServiceClinicModel {
  int id;
  String name;
  String desc;
  String image;

  ServiceClinicModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.image,
  });

  factory ServiceClinicModel.fromJson(Map<String, dynamic> json) {
    return ServiceClinicModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      desc: json['desc'] ?? '',
    );
  }
}
