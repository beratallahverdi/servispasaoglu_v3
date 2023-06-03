import 'dart:convert';

import 'package:collection/collection.dart';

import 'engine.dart';

class Ecu {
  int? ecuId;
  int? engineId;
  String? ecuName;
  int? ecuStatus;
  String? slug;
  String? ecuManufacturer;
  String? ecuType;
  String? ecuCategory;
  Engine? engine;

  Ecu({
    this.ecuId,
    this.engineId,
    this.ecuName,
    this.ecuStatus,
    this.slug,
    this.ecuManufacturer,
    this.ecuType,
    this.ecuCategory,
    this.engine,
  });

  @override
  String toString() {
    return 'Ecu(ecuId: $ecuId, engineId: $engineId, ecuName: $ecuName, ecuStatus: $ecuStatus, slug: $slug, ecuManufacturer: $ecuManufacturer, ecuType: $ecuType, ecuCategory: $ecuCategory, engine: $engine)';
  }

  factory Ecu.fromMap(Map<String, dynamic> data) => Ecu(
        ecuId: data['ecu_id'] as int?,
        engineId: data['engine_id'] as int?,
        ecuName: data['ecu_name'] as String?,
        ecuStatus: data['ecu_status'] as int?,
        slug: data['slug'] as String?,
        ecuManufacturer: data['ecu_manufacturer'] as String?,
        ecuType: data['ecu_type'] as String?,
        ecuCategory: data['ecu_category'] as String?,
        engine: data['engine'] == null
            ? null
            : Engine.fromMap(data['engine'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'ecu_id': ecuId,
        'engine_id': engineId,
        'ecu_name': ecuName,
        'ecu_status': ecuStatus,
        'slug': slug,
        'ecu_manufacturer': ecuManufacturer,
        'ecu_type': ecuType,
        'ecu_category': ecuCategory,
        'engine': engine?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Ecu].
  factory Ecu.fromJson(String data) {
    return Ecu.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Ecu] to a JSON string.
  String toJson() => json.encode(toMap());

  Ecu copyWith({
    int? ecuId,
    int? engineId,
    String? ecuName,
    int? ecuStatus,
    String? slug,
    String? ecuManufacturer,
    String? ecuType,
    String? ecuCategory,
    Engine? engine,
  }) {
    return Ecu(
      ecuId: ecuId ?? this.ecuId,
      engineId: engineId ?? this.engineId,
      ecuName: ecuName ?? this.ecuName,
      ecuStatus: ecuStatus ?? this.ecuStatus,
      slug: slug ?? this.slug,
      ecuManufacturer: ecuManufacturer ?? this.ecuManufacturer,
      ecuType: ecuType ?? this.ecuType,
      ecuCategory: ecuCategory ?? this.ecuCategory,
      engine: engine ?? this.engine,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Ecu) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      ecuId.hashCode ^
      engineId.hashCode ^
      ecuName.hashCode ^
      ecuStatus.hashCode ^
      slug.hashCode ^
      ecuManufacturer.hashCode ^
      ecuType.hashCode ^
      ecuCategory.hashCode ^
      engine.hashCode;
}
