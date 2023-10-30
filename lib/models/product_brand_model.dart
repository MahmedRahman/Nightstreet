// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProuctBrandModel {
  final int id;
  final String image;
  final String name;

  ProuctBrandModel({
    required this.id,
    required this.image,
    required this.name,
  });

  factory ProuctBrandModel.fromJson(Map<String, dynamic> json) {
    return ProuctBrandModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
    );
  }
}
