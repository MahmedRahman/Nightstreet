class ProductImage {
  String image;

  ProductImage({
    //required this.id,
    required this.image,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      image: json['image'],
    );
  }
}
