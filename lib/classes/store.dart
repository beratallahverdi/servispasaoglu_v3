import 'dart:convert';

import 'package:collection/collection.dart';

class Store {
  String? sellerName;
  String? sellerAddress;
  String? sellerPhone;
  String? city;
  String? country;
  int? sellerCredit;
  String? sellerEmail;
  String? sellerImage;

  Store({
    this.sellerName,
    this.sellerAddress,
    this.sellerPhone,
    this.city,
    this.country,
    this.sellerCredit,
    this.sellerEmail,
    this.sellerImage,
  });

  @override
  String toString() {
    return 'Store(sellerName: $sellerName, sellerAddress: $sellerAddress, sellerPhone: $sellerPhone, city: $city, country: $country, sellerCredit: $sellerCredit, sellerEmail: $sellerEmail, sellerImage: $sellerImage)';
  }

  factory Store.fromMap(Map<String, dynamic> data) => Store(
        sellerName: data['seller_name'] as String?,
        sellerAddress: data['seller_address'] as String?,
        sellerPhone: data['seller_phone'] as String?,
        city: data['city'] as String?,
        country: data['country'] as String?,
        sellerCredit: data['seller_credit'] as int?,
        sellerEmail: data['seller_email'] as String?,
        sellerImage: data['seller_image'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'seller_name': sellerName,
        'seller_address': sellerAddress,
        'seller_phone': sellerPhone,
        'city': city,
        'country': country,
        'seller_credit': sellerCredit,
        'seller_email': sellerEmail,
        'seller_image': sellerImage,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Store].
  factory Store.fromJson(String data) {
    return Store.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Store] to a JSON string.
  String toJson() => json.encode(toMap());

  Store copyWith({
    String? sellerName,
    String? sellerAddress,
    String? sellerPhone,
    String? city,
    String? country,
    int? sellerCredit,
    String? sellerEmail,
    String? sellerImage,
  }) {
    return Store(
      sellerName: sellerName ?? this.sellerName,
      sellerAddress: sellerAddress ?? this.sellerAddress,
      sellerPhone: sellerPhone ?? this.sellerPhone,
      city: city ?? this.city,
      country: country ?? this.country,
      sellerCredit: sellerCredit ?? this.sellerCredit,
      sellerEmail: sellerEmail ?? this.sellerEmail,
      sellerImage: sellerImage ?? this.sellerImage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Store) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  void setSellerCredit(int sellerCredit) {
    this.sellerCredit = sellerCredit;
  }

  @override
  int get hashCode =>
      sellerName.hashCode ^
      sellerAddress.hashCode ^
      sellerPhone.hashCode ^
      city.hashCode ^
      country.hashCode ^
      sellerCredit.hashCode ^
      sellerEmail.hashCode ^
      sellerImage.hashCode;
}
