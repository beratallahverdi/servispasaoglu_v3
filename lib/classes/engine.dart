import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:servispasaoglu_v3/api/types.dart';
import 'package:servispasaoglu_v3/classes/ecu.dart';

import 'generation.dart';
import 'power.dart';
import 'read_method.dart';
import 'torque.dart';

class Engine {
  int? engineId;
  int? generationId;
  String? engineName;
  int? engineStatus;
  String? slug;
  String? fuelType;
  int? cylinderCapacity;
  String? bore;
  String? stroke;
  String? compressionRatio;
  dynamic turboType;
  dynamic engineCode;
  Generation? generation;
  List<ReadMethod>? readMethods;
  List<dynamic>? tuningOptions;
  Power? power;
  Torque? torque;

  Engine({
    this.engineId,
    this.generationId,
    this.engineName,
    this.engineStatus,
    this.slug,
    this.fuelType,
    this.cylinderCapacity,
    this.bore,
    this.stroke,
    this.compressionRatio,
    this.turboType,
    this.engineCode,
    this.generation,
    this.readMethods,
    this.tuningOptions,
    this.power,
    this.torque,
  });

  @override
  String toString() {
    return 'Engine(engineId: $engineId, generationId: $generationId, engineName: $engineName, engineStatus: $engineStatus, slug: $slug, fuelType: $fuelType, cylinderCapacity: $cylinderCapacity, bore: $bore, stroke: $stroke, compressionRatio: $compressionRatio, turboType: $turboType, engineCode: $engineCode, generation: $generation, readMethods: $readMethods, tuningOptions: $tuningOptions, power: $power, torque: $torque)';
  }

  factory Engine.fromMap(Map<String, dynamic> data) => Engine(
        engineId: data['engine_id'] as int?,
        generationId: data['generation_id'] as int?,
        engineName: data['engine_name'] as String?,
        engineStatus: data['engine_status'] as int?,
        slug: data['slug'] as String?,
        fuelType: data['fuel_type'] as String?,
        cylinderCapacity: data['cylinder_capacity'] as int?,
        bore: data['bore'] as String?,
        stroke: data['stroke'] as String?,
        compressionRatio: data['compression_ratio'] as String?,
        turboType: data['turbo_type'] as dynamic,
        engineCode: data['engine_code'] as dynamic,
        generation: data['generation'] == null
            ? null
            : Generation.fromMap(data['generation'] as Map<String, dynamic>),
        readMethods: (data['read_methods'] as List<dynamic>?)
            ?.map((e) => ReadMethod.fromMap(e as Map<String, dynamic>))
            .toList(),
        tuningOptions: data['tuning_options'] as List<dynamic>?,
        power: data['power'] == null
            ? null
            : Power.fromMap(data['power'] as Map<String, dynamic>),
        torque: data['torque'] == null
            ? null
            : Torque.fromMap(data['torque'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'engine_id': engineId,
        'generation_id': generationId,
        'engine_name': engineName,
        'engine_status': engineStatus,
        'slug': slug,
        'fuel_type': fuelType,
        'cylinder_capacity': cylinderCapacity,
        'bore': bore,
        'stroke': stroke,
        'compression_ratio': compressionRatio,
        'turbo_type': turboType,
        'engine_code': engineCode,
        'generation': generation?.toMap(),
        'read_methods': readMethods?.map((e) => e.toMap()).toList(),
        'tuning_options': tuningOptions,
        'power': power?.toMap(),
        'torque': torque?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Engine].
  factory Engine.fromJson(String data) {
    return Engine.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Engine] to a JSON string.
  String toJson() => json.encode(toMap());

  Engine copyWith({
    int? engineId,
    int? generationId,
    String? engineName,
    int? engineStatus,
    String? slug,
    String? fuelType,
    int? cylinderCapacity,
    String? bore,
    String? stroke,
    String? compressionRatio,
    dynamic turboType,
    dynamic engineCode,
    Generation? generation,
    List<ReadMethod>? readMethods,
    List<dynamic>? tuningOptions,
    Power? power,
    Torque? torque,
  }) {
    return Engine(
      engineId: engineId ?? this.engineId,
      generationId: generationId ?? this.generationId,
      engineName: engineName ?? this.engineName,
      engineStatus: engineStatus ?? this.engineStatus,
      slug: slug ?? this.slug,
      fuelType: fuelType ?? this.fuelType,
      cylinderCapacity: cylinderCapacity ?? this.cylinderCapacity,
      bore: bore ?? this.bore,
      stroke: stroke ?? this.stroke,
      compressionRatio: compressionRatio ?? this.compressionRatio,
      turboType: turboType ?? this.turboType,
      engineCode: engineCode ?? this.engineCode,
      generation: generation ?? this.generation,
      readMethods: readMethods ?? this.readMethods,
      tuningOptions: tuningOptions ?? this.tuningOptions,
      power: power ?? this.power,
      torque: torque ?? this.torque,
    );
  }

  Future<List<Ecu>> getEcus() async {
    return TypesAPI.getEcus(engine: this);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Engine) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      engineId.hashCode ^
      generationId.hashCode ^
      engineName.hashCode ^
      engineStatus.hashCode ^
      slug.hashCode ^
      fuelType.hashCode ^
      cylinderCapacity.hashCode ^
      bore.hashCode ^
      stroke.hashCode ^
      compressionRatio.hashCode ^
      turboType.hashCode ^
      engineCode.hashCode ^
      generation.hashCode ^
      readMethods.hashCode ^
      tuningOptions.hashCode ^
      power.hashCode ^
      torque.hashCode;
}
