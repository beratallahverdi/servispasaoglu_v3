import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:servispasaoglu_v3/api/types.dart';
import 'package:servispasaoglu_v3/classes/generation.dart';

import 'brand.dart';

class Model {
  int? modelId;
  int? brandId;
  String? modelName;
  int? modelStatus;
  String? slug;
  Brand? brand;

  Model({
    this.modelId,
    this.brandId,
    this.modelName,
    this.modelStatus,
    this.slug,
    this.brand,
  });

  @override
  String toString() {
    return 'Model(modelId: $modelId, brandId: $brandId, modelName: $modelName, modelStatus: $modelStatus, slug: $slug, brand: $brand)';
  }

  factory Model.fromMap(Map<String, dynamic> data) => Model(
        modelId: data['model_id'] as int?,
        brandId: data['brand_id'] as int?,
        modelName: data['model_name'] as String?,
        modelStatus: data['model_status'] as int?,
        slug: data['slug'] as String?,
        brand: data['brand'] == null
            ? null
            : Brand.fromMap(data['brand'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'model_id': modelId,
        'brand_id': brandId,
        'model_name': modelName,
        'model_status': modelStatus,
        'slug': slug,
        'brand': brand?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Model].
  factory Model.fromJson(String data) {
    return Model.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Model] to a JSON string.
  String toJson() => json.encode(toMap());

  Model copyWith({
    int? modelId,
    int? brandId,
    String? modelName,
    int? modelStatus,
    String? slug,
    Brand? brand,
  }) {
    return Model(
      modelId: modelId ?? this.modelId,
      brandId: brandId ?? this.brandId,
      modelName: modelName ?? this.modelName,
      modelStatus: modelStatus ?? this.modelStatus,
      slug: slug ?? this.slug,
      brand: brand ?? this.brand,
    );
  }

  Future<List<Generation>> getGenerations() async {
    return TypesAPI.getGenerations(model: this);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Model) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      modelId.hashCode ^
      brandId.hashCode ^
      modelName.hashCode ^
      modelStatus.hashCode ^
      slug.hashCode ^
      brand.hashCode;
}
