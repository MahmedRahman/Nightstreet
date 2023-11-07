class ProductImage {
  //int id;
  String image;

  ProductImage({
    //required this.id,
    required this.image,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
     // id: json['id'],
      image: json['image'],
    );
  }
}
