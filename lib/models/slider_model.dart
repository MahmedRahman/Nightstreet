// class SliderData {
//   final bool success;
//   final int responseCode;
//   final String message;
//   final List<SliderItem> data;

//   SliderData({
//     required this.success,
//     required this.responseCode,
//     required this.message,
//     required this.data,
//   });

//   factory SliderData.fromJson(Map<String, dynamic> json) {
//     List<dynamic> dataList = json['data'];
//     List<SliderItem> sliderItems = dataList.map((item) {
//       return SliderItem.fromJson(item);
//     }).toList();

//     return SliderData(
//       success: json['success'],
//       responseCode: json['response_code'],
//       message: json['message'],
//       data: sliderItems,
//     );
//   }
// }

class SliderModel {
  final int id;
  final String name;
  final String image;
  final String type;
  final String? url;
  final int? modelId;
  final String? modelType;

  SliderModel({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    this.url,
    this.modelId,
    this.modelType,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      url: json['url'],
      type: json['type'],
      modelId: json['model_id'],
      modelType: json['model_type'],
    );
  }
}
