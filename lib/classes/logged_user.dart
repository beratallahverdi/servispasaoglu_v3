import 'dart:convert';

class ServisPasaogluUser {
  final int? userId;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final int? sellerId;
  final String? email;
  final String? phoneNumber;
  final int? userStatusId;
  final String? sellerName;
  final String? sellerAddress;
  final String? sellerPhone;
  final String? password;
  final String? city;
  final String? country;
  final int? sellerCredit;
  final String? status;
  final String? apiKey;
  final int? isAdmin;

  ServisPasaogluUser({
    required this.userId,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.sellerId,
    required this.email,
    required this.phoneNumber,
    required this.userStatusId,
    required this.sellerName,
    required this.sellerAddress,
    required this.sellerPhone,
    required this.password,
    required this.city,
    required this.country,
    required this.sellerCredit,
    required this.status,
    required this.apiKey,
    required this.isAdmin,
  });

  static Map<int, ServisPasaogluUser> dataToList(List<dynamic> datas) {
    List<ServisPasaogluUser> all = <ServisPasaogluUser>[];
    for (var map in datas) {
      all.add(ServisPasaogluUser.fromJson(map));
    }
    return all.asMap();
  }

  factory ServisPasaogluUser.fromJson(Map<String, dynamic> map) {
    return ServisPasaogluUser(
      userId: map['user_id']?.toInt(),
      userName: map['user_name'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      sellerId: map['seller_id']?.toInt(),
      email: map['email'],
      phoneNumber: map['phone_number'],
      userStatusId: map['user_status']?.toInt(),
      sellerName: map['seller_name'],
      sellerAddress: map['seller_address'],
      sellerPhone: map['seller_phone'],
      password: map['password'],
      city: map['city'],
      country: map['country'],
      sellerCredit: map['seller_credit']?.toInt(),
      status: map['status'],
      apiKey: map['api_key'],
      isAdmin: map['isAdmin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_name': userName,
      'first_name': firstName,
      'last_name': lastName,
      'seller_id': sellerId,
      'email': email,
      'phone_number': phoneNumber,
      'user_status': userStatusId,
      'seller_name': sellerName,
      'seller_address': sellerAddress,
      'seller_phone': sellerPhone,
      'password': password,
      'city': city,
      'country': country,
      'seller_credit': sellerCredit,
      'status': status,
      'api_key': apiKey,
      'isAdmin': isAdmin,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
