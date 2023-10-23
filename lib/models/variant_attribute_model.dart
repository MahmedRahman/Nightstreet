class VariantAttribute {
  final int id;
  final String name;
  final int active;

  VariantAttribute({
    required this.id,
    required this.name,
    required this.active,
  });

  factory VariantAttribute.fromJson(Map<String, dynamic> json) {
    return VariantAttribute(
      id: json['id'],
      name: json['name'],
      active: json['active'],
    );
  }
}
