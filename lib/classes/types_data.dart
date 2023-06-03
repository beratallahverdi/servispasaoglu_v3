import 'dart:convert';

import 'package:collection/collection.dart';

import 'brand.dart';
import 'ecu.dart';
import 'engine.dart';
import 'generation.dart';
import 'model.dart';

class TypesData {
  List<Brand>? brand;
  List<Model>? model;
  List<Generation>? generation;
  List<Engine>? engine;
  List<Ecu>? ecu;

  TypesData({this.brand, this.model, this.generation, this.engine, this.ecu});

  @override
  String toString() {
    return 'Data(brand: $brand, model: $model, generation: $generation, engine: $engine, ecu: $ecu)';
  }

  factory TypesData.fromMap(Map<String, dynamic> data) => TypesData(
        brand: (data['brand'] as List<dynamic>?)
            ?.map((e) => Brand.fromMap(e as Map<String, dynamic>))
            .toList(),
        model: (data['model'] as List<dynamic>?)
            ?.map((e) => Model.fromMap(e as Map<String, dynamic>))
            .toList(),
        generation: (data['generation'] as List<dynamic>?)
            ?.map((e) => Generation.fromMap(e as Map<String, dynamic>))
            .toList(),
        engine: (data['engine'] as List<dynamic>?)
            ?.map((e) => Engine.fromMap(e as Map<String, dynamic>))
            .toList(),
        ecu: (data['ecu'] as List<dynamic>?)
            ?.map((e) => Ecu.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'brand': brand?.map((e) => e.toMap()).toList(),
        'model': model?.map((e) => e.toMap()).toList(),
        'generation': generation?.map((e) => e.toMap()).toList(),
        'engine': engine?.map((e) => e.toMap()).toList(),
        'ecu': ecu?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory TypesData.fromJson(String data) {
    return TypesData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  TypesData copyWith({
    List<Brand>? brand,
    List<Model>? model,
    List<Generation>? generation,
    List<Engine>? engine,
    List<Ecu>? ecu,
  }) {
    return TypesData(
      brand: brand ?? this.brand,
      model: model ?? this.model,
      generation: generation ?? this.generation,
      engine: engine ?? this.engine,
      ecu: ecu ?? this.ecu,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TypesData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      brand.hashCode ^
      model.hashCode ^
      generation.hashCode ^
      engine.hashCode ^
      ecu.hashCode;
}
