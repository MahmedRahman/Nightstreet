// ignore_for_file: public_member_api_docs, sort_constructors_first
class ComplaintCategoryModel {
  final int id;
  final String name;

  const ComplaintCategoryModel({
    required this.id,
    required this.name,
  });

  factory ComplaintCategoryModel.fromJson(Map<String, dynamic> json) {
    return ComplaintCategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
