class ComplaintModel {
  final DateTime date;
  final int id;
  final bool closed;
  final String status;
  const ComplaintModel({
    required this.date,
    required this.id,
    required this.closed,
    required this.status,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      date: DateTime.parse(json['date']),
      id: json['id'],
      closed: json['closed'],
      status: json['status'],
    );
  }
}
