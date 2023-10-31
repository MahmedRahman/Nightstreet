class AppointmentModel {
  final Offer offer;
  final String status;
  final String doctorName;
  final String doctorId;
  final String ClinicName;
  final int id;
  final int? branchId;
  final String datetime;

  const AppointmentModel({
    required this.offer,
    required this.status,
    required this.doctorName,
    required this.doctorId,
    required this.ClinicName,
    required this.datetime,
    required this.id,
    this.branchId,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      offer: Offer.fromJson(json['offer']),
      status: json['status'],
      doctorName: json['doctor'] == null ? '' : json['doctor']['name'],
      doctorId: json['doctor'] == null ? '' : json['doctor']['id'].toString(),
      ClinicName: json['branch']['name'],
      datetime: json['datetime'],
      id: json['id'],
      branchId: json['branch']['id'],
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
