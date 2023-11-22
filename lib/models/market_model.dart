// ignore_for_file: public_member_api_docs, sort_constructors_first

class MarketModel {
  final int id;
  final String name;
  final String desc;
  final String image;
  final num rate;
  final num totalRate;
  bool isFavorite;
  MarketModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.image,
    required this.isFavorite,
    required this.rate,
    required this.totalRate,
  });

  factory MarketModel.fromMap(Map<String, dynamic> map) {
    return MarketModel(
      id: map['id'] as int,
      name: map['name'] as String,
      desc: (map['desc'] ?? '') as String,
      image: map['image'] as String,
      isFavorite: map['is_favorite'] as bool,
      rate: map['total_rate_avg'] as num,
      totalRate: map['total_rate_count'] as num,
    );
  }
}
