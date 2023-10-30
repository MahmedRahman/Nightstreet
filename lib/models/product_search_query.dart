// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductQueryParameters {
  String? categoryId;
  String? name;
  double? startPrice;
  double? endPrice;
  String? filter;
  List<String>? brandIds;
  int? limit;
  int? adminFeatured;

  ProductQueryParameters({
    this.categoryId,
    this.name,
    this.startPrice,
    this.endPrice,
    this.filter,
    this.brandIds,
    this.limit,
    this.adminFeatured,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};

    if (categoryId != null) {
      data['category_id'] = categoryId;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (startPrice != null) {
      data['start_price'] = startPrice.toString();
    }
    if (endPrice != null) {
      data['end_price'] = endPrice.toString();
    }
    if (filter != null) {
      data['filter'] = filter;
    }
    if (brandIds != null) {
      data['brand_ids'] = [brandIds!.join(",")];
    }
    if (limit != null) {
      data['limit'] = limit.toString();
    }
    if (adminFeatured != null) {
      data['admin_featured'] = adminFeatured.toString();
    }

    return data;
  }

  @override
  String toString() {
    return 'ProductQueryParameters(categoryId: $categoryId, name: $name, startPrice: $startPrice, endPrice: $endPrice, filter: $filter, brandIds: $brandIds, limit: $limit, adminFeatured: $adminFeatured)';
  }
}

String buildProductUrl(
  String baseUrl,
  int page, {
  ProductQueryParameters? queryParams,
}) {
  print('qqqq $queryParams');
  final Map<String, dynamic> queryParameters = queryParams?.toMap() ?? {};

  final List<String> parts = [];
  queryParameters.forEach((key, value) {
    if (value != null &&
        value.toString().isNotEmpty &&
        value.toString() != '[]') {
      parts.add('$key=$value');
    }
  });

  final String queryString = parts.join('&');
  print('queryString is empty ${queryString.isEmpty}');
  if (queryString.isNotEmpty) {
    return '$baseUrl/products/get?$queryString&page=$page';
  } else {
    return '$baseUrl/products/get?page=$page';
  }
}
