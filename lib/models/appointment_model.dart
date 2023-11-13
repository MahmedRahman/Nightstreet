class AppointmentModel {
  final Offer offer;
  final String status;
  final String doctorName;
  final int doctorId;
  final String ClinicName;
  final int id;
  final int? branchId;
  final String datetime;
  final String date_time;

  final String time_format;
  final String notes;

  final bool? can_rate;
  final bool? can_update;

  const AppointmentModel({
    required this.offer,
    required this.status,
    required this.doctorName,
    required this.doctorId,
    required this.ClinicName,
    required this.datetime,
    required this.id,
    required this.can_rate,
    required this.can_update,
    required this.time_format,
    required this.notes,
    required this.date_time,
    this.branchId,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      offer: Offer.fromJson(json['offer']),
      status: json['status'],
      doctorName: json['doctor'] == null ? '' : json['doctor']['name'],
      doctorId: json['doctor'] == null ? 0 : json['doctor']['id'],
      ClinicName: json['branch']['name'],
      datetime: json['datetime'].toString(),
      id: json['id'],
      can_rate: json['can_rate'],
      can_update: json['can_update'],
      time_format: json['time_format'].toString(),
      branchId: json['branch']['id'],
      notes: json['notes'] ?? "",
      date_time: json['date_time'].toString(),
    );
  }
}

class Offer {
  final int id;
  final String name;
  final int oldPrice;
  final int price;
  final String image;

  const Offer({
    required this.id,
    required this.name,
    required this.oldPrice,
    required this.price,
    required this.image,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] as int,
      name: json['name'] as String,
      oldPrice: (json['oldPrice'] ?? 0) as int,
      price: json['price'] as int,
      image: json['image'] as String,
    );
  }
}
