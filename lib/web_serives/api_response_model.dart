class ResponseModel {
  final String url;

  final bool status;
  final int statusCode;
  final String? message;
  final dynamic data;
  final dynamic query;

  ResponseModel({
    required this.url,
    required this.status,
    required this.statusCode,
    required this.data,
    required this.query,
    this.message,
  });
}
