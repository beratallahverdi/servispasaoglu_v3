import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:servispasaoglu_v3/api/types.dart';
import 'package:servispasaoglu_v3/classes/model.dart';

class Brand {
  int? brandId;
  String? brandName;
  String? logo;
  String? vehicleType;
  int? brandStatus;
  String? slug;

  Brand({
    this.brandId,
    this.brandName,
    this.logo,
    this.vehicleType,
    this.brandStatus,
    this.slug,
  });

  @override
  String toString() {
    return 'Brand(brandId: $brandId, brandName: $brandName, logo: $logo, vehicleType: $vehicleType, brandStatus: $brandStatus, slug: $slug)';
  }

  factory Brand.fromMap(Map<String, dynamic> data) => Brand(
        brandId: data['brand_id'] as int?,
        brandName: data['brand_name'] as String?,
        logo: data['logo'] as String?,
        vehicleType: data['vehicle_type'] as String?,
        brandStatus: data['brand_status'] as int?,
        slug: data['slug'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'brand_id': brandId,
        'brand_name': brandName,
        'logo': logo,
        'vehicle_type': vehicleType,
        'brand_status': brandStatus,
        'slug': slug,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Brand].
  factory Brand.fromJson(String data) {
    return Brand.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Brand] to a JSON string.
  String toJson() => json.encode(toMap());

  Brand copyWith({
    int? brandId,
    String? brandName,
    String? logo,
    String? vehicleType,
    int? brandStatus,
    String? slug,
  }) {
    return Brand(
      brandId: brandId ?? this.brandId,
      brandName: brandName ?? this.brandName,
      logo: logo ?? this.logo,
      vehicleType: vehicleType ?? this.vehicleType,
      brandStatus: brandStatus ?? this.brandStatus,
      slug: slug ?? this.slug,
    );
  }

  Future<List<Model>> getModels() async {
    return TypesAPI.getModels(brand: this);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Brand) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      brandId.hashCode ^
      brandName.hashCode ^
      logo.hashCode ^
      vehicleType.hashCode ^
      brandStatus.hashCode ^
      slug.hashCode;
}
