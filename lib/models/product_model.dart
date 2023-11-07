import 'package:krzv2/models/product_category_model.dart';
import 'package:krzv2/models/product_image_model.dart';
import 'package:krzv2/models/variants_model.dart';

class ProductModel {
  int id;
  String name;
  String desc;
  String image;
  double price;
  String usage;
  int quantity;
  double oldPrice;
  String cashback;
  Brand brand;
  List<ProductCategory> categories;
  List<ProductImage> images;
  final List<Variant> variants;
  double totalRateAvg;
  int totalRateCount;
  bool isFavorite;
  int active;
  String weight;
  String barcode;
  int adminFeatured;

  ProductModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.usage,
    required this.image,
    required this.oldPrice,
    required this.price,
    required this.quantity,
    required this.cashback,
    required this.brand,
    required this.categories,
    required this.images,
    required this.totalRateAvg,
    required this.totalRateCount,
    required this.isFavorite,
    required this.active,
    required this.weight,
    required this.barcode,
    required this.adminFeatured,
    required this.variants,
  });

  static ProductModel dummyProduct = ProductModel(
    id: 1,
    name: "Sample Product",
    desc: "This is a sample product description.",
    image: "sample_image.jpg",
    price: 19.99,
    usage: "Sample product usage information.",
    quantity: 100,
    oldPrice: 24.99,
    cashback: "5% cashback on this product",
    brand: Brand(
      id: 1,
      name: 'brand name',
      active: 1,
      image: '',
    ),
    categories: [
      ProductCategory(
        id: 1,
        name: 'name',
        image: '',
      )
    ], // Create a dummy ProductCategory list
    images: [
      ProductImage(
        //id: 1,
        image: '',
      )
    ], // Create va dummy ProductImage list
    totalRateAvg: 4.5,
    totalRateCount: 1000,
    isFavorite: false,
    active: 1,
    weight: "1.5 kg",
    barcode: "1234567890",
    adminFeatured: 1,
    variants: [],
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      usage: json['usage'],
      image: json['image'],
      oldPrice: json['old_price'].toDouble(),
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      cashback: json['cashback'],
      brand: Brand.fromJson(json['brand']),
      categories: List<ProductCategory>.from(
        json['categories'].map((category) => ProductCategory.fromJson(category)),
      ),
      images: List<ProductImage>.from(
        json['images'].map((image) => ProductImage.fromJson(image)),
      ),
      totalRateAvg: json['total_rate_avg'].toDouble(),
      totalRateCount: json['total_rate_count'],
      isFavorite: json['is_favorite'],
      active: json['active'],
      weight: json['weight'],
      barcode: json['barcode'],
      adminFeatured: json['admin_featured'],
      variants: (json['variants'] as List).length == 0
          ? []
          : List<Variant>.from(
              json['variants'].map((category) => Variant.fromJson(category)),
            ),
    );
  }
}

class Brand {
  int id;
  String name;
  int active;
  String image;

  Brand({
    required this.id,
    required this.name,
    required this.active,
    required this.image,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
      active: json['active'],
      image: json['image'],
    );
  }
}
