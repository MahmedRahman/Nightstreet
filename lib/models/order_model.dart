// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderModel {
  int id;
  double subTotal;
  double tax;
  double taxPercentage;
  double discount;
  double shippingPrice;
  double total;
  int isPaid;
  String? notes;
  String createdAt;
  String status;
  String statusNum;
  String paymentType;
  bool canRate;
  bool canCancel;
  List<OrderProdudctsDetails>? details;

  OrderModel({
    required this.id,
    required this.subTotal,
    required this.tax,
    required this.taxPercentage,
    required this.discount,
    required this.shippingPrice,
    required this.total,
    required this.isPaid,
    required this.createdAt,
    required this.status,
    required this.statusNum,
    required this.paymentType,
    required this.canRate,
    required this.canCancel,
    this.notes,
    this.details,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      subTotal: double.parse(json['sub_total']),
      tax: double.parse(json['tax']),
      taxPercentage: double.parse(json['tax_percentage']),
      discount: double.parse(json['discount']),
      shippingPrice: double.parse(json['shipping_price']),
      total: double.parse(json['total']),
      isPaid: json['is_paid'],
      notes: json['notes'],
      createdAt: json['created_at'],
      status: json['status'],
      statusNum: json['status_num'],
      paymentType: json['payment_type'],
      canRate: json['can_rate'],
      canCancel: json['can_cancel'],
      details: json['details'] == null
          ? []
          : List<OrderProdudctsDetails>.from(
              json['details'].map(
                (detail) => OrderProdudctsDetails.fromMap(detail),
              ),
            ),
    );
  }
}

class OrderProdudctsDetails {
  final int quantity;
  final int productId;
  final String productName;
  final String productImage;
  final num price;
  final num oldPrice;

  OrderProdudctsDetails({
    required this.quantity,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.oldPrice,
  });

  factory OrderProdudctsDetails.fromMap(Map<String, dynamic> map) {
    return OrderProdudctsDetails(
      quantity: map['quantity'] as int,
      productName: map['product']['name'] as String,
      productId: map['product']['id'] as int,
      productImage: map['product']['image'] as String,
      price: map['product']['price'] as num,
      oldPrice: map['product']['old_price'] as num,
    );
  }
}
