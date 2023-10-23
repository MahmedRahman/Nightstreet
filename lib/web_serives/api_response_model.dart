class ResponseModel {
  final bool status;
  final int statusCode;
  final String? message;
  final dynamic data;

  ResponseModel({
    required this.status,
    required this.statusCode,
    required this.data,
    this.message,
  });
}
