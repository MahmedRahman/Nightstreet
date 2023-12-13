class ComplaintModel {
  final DateTime date;
  final int id;
  final bool closed;
  final String status;
  final String category;
  const ComplaintModel({
    required this.date,
    required this.id,
    required this.closed,
    required this.status,
    required this.category,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      date: DateTime.parse(json['date']),
      id: json['id'],
      closed: json['closed'],
      status: json['status'],
      category: json['category']['name'],
    );
  }
}
