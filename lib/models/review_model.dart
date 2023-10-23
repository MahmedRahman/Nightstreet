// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReviewModel {
  final String name;
  final int rate;
  final String message;
  final String date;

  ReviewModel({
    required this.name,
    required this.rate,
    required this.message,
    required this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      name: json['name'],
      rate: json['rate'],
      message: json['message'],
      date: json['date'],
    );
  }
}
