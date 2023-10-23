class Prediction {
  final String description;

  final String placeId;
  final String reference;

  Prediction({
    required this.description,
    required this.placeId,
    required this.reference,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      description: json['description'],
      placeId: json['place_id'],
      reference: json['reference'],
    );
  }
}
