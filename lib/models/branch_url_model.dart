class BranchQueryParameters {
  String? categoryId;
  String? name;
  String? filter;
  String? clinicId;
  double? lat;
  double? lng;

  BranchQueryParameters({
    this.categoryId,
    this.name,
    this.filter,
    this.clinicId,
    this.lat,
    this.lng,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};

    if (categoryId != null) {
      data['category_id'] = categoryId;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (filter != null) {
      data['filter'] = filter;
    }

    if (clinicId != null) {
      data['clinic_id'] = clinicId;
    }
    if (lat != null) {
      data['lat'] = lat.toString();
    }
    if (lng != null) {
      data['lng'] = lng.toString();
    }

    return data;
  }
}

String buildBranchesUrl(String baseUrl, int page,
    {BranchQueryParameters? queryParams = null}) {
  if (queryParams == null) return '$baseUrl/branches/get?page=$page';
  final Map<String, dynamic> queryParameters = queryParams.toMap();

  final List<String> parts = [];
  queryParameters.forEach((key, value) {
    if (value != null && value.toString().isNotEmpty) {
      parts.add('$key=$value');
    }
  });

  final String queryString = parts.join('&');
  if (queryString.isNotEmpty) {
    return '$baseUrl/branches/get?$queryString&page=$page';
  } else {
    return '$baseUrl/branches/get?page=$page';
  }
}
