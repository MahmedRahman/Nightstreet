class ComplaintCategoryModel {
  final int id;
  final String name;
  final List<ComplaintCategoryModel> subCategories;

  const ComplaintCategoryModel({
    required this.id,
    required this.name,
    required this.subCategories,
  });

  factory ComplaintCategoryModel.fromJson(Map<String, dynamic> json) {
    return ComplaintCategoryModel(
      id: json['id'],
      name: json['name'],
      subCategories: List<ComplaintCategoryModel>.from(
        json['sub_categories'].map(
          (category) => ComplaintCategoryModel.fromJson(category),
        ),
      ),
    );
  }
}
