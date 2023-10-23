import 'package:krzv2/models/variant_attribute_model.dart';

class Variant {
  final int id;
  final VariantAttribute attribute;
  final String name;
  final int quantity;
  final String barcode;

  Variant({
    required this.id,
    required this.attribute,
    required this.name,
    required this.quantity,
    required this.barcode,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      attribute: VariantAttribute.fromJson(json['attribute']),
      name: json['name'],
      quantity: json['quantity'],
      barcode: json['barcode'],
    );
  }
}
