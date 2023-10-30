class ShippingCompaniesModel {
  final int id;
  final String name;
  final String deliveryTime;
  final num cost;
  ShippingCompaniesModel({
    required this.id,
    required this.name,
    required this.deliveryTime,
    required this.cost,
  });

  factory ShippingCompaniesModel.fromMap(Map<String, dynamic> map) {
    return ShippingCompaniesModel(
      id: map['id'] as int,
      name: map['title_arabic'] as String,
      deliveryTime: map['approximate_delivery_time_arabic'] as String,
      cost: map['rate'] as num,
    );
  }

  @override
  bool operator ==(covariant ShippingCompaniesModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        other.deliveryTime == deliveryTime &&
        other.cost == cost;
  }

  @override
  int get hashCode =>
      name.hashCode ^ deliveryTime.hashCode ^ cost.hashCode ^ id.hashCode;
}
