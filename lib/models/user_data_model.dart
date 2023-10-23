class UserData {
  int id;
  String name;
  String email;
  String phone;
  String image;
  String type;
  int active;
  String gender;
  String birthDate;
  String walletBalance;
  int notificationsCount;
  int cartCount;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.type,
    required this.active,
    required this.gender,
    required this.birthDate,
    required this.walletBalance,
    required this.notificationsCount,
    required this.cartCount,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'] ?? '',
      phone: json['phone'],
      image: json['image'],
      type: json['type'],
      active: json['active'],
      gender: json['gender'] ?? '',
      birthDate: json['birth_date'] ?? '',
      walletBalance: json['wallet_balance'],
      notificationsCount: json['notifications_count'],
      cartCount: json['cart_count'],
    );
  }
}
