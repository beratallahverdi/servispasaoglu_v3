import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:servispasaoglu_v3/api/types.dart';
import 'package:servispasaoglu_v3/classes/engine.dart';

import 'model.dart';

class Generation {
  int? generationId;
  int? modelId;
  String? generationName;
  int? generationStatus;
  String? slug;
  Model? model;

  Generation({
    this.generationId,
    this.modelId,
    this.generationName,
    this.generationStatus,
    this.slug,
    this.model,
  });

  @override
  String toString() {
    return 'Generation(generationId: $generationId, modelId: $modelId, generationName: $generationName, generationStatus: $generationStatus, slug: $slug, model: $model)';
  }

  factory Generation.fromMap(Map<String, dynamic> data) => Generation(
        generationId: data['generation_id'] as int?,
        modelId: data['model_id'] as int?,
        generationName: data['generation_name'] as String?,
        generationStatus: data['generation_status'] as int?,
        slug: data['slug'] as String?,
        model: data['model'] == null
            ? null
            : Model.fromMap(data['model'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'generation_id': generationId,
        'model_id': modelId,
        'generation_name': generationName,
        'generation_status': generationStatus,
        'slug': slug,
        'model': model?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Generation].
  factory Generation.fromJson(String data) {
    return Generation.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Generation] to a JSON string.
  String toJson() => json.encode(toMap());

  Generation copyWith({
    int? generationId,
    int? modelId,
    String? generationName,
    int? generationStatus,
    String? slug,
    Model? model,
  }) {
    return Generation(
      generationId: generationId ?? this.generationId,
      modelId: modelId ?? this.modelId,
      generationName: generationName ?? this.generationName,
      generationStatus: generationStatus ?? this.generationStatus,
      slug: slug ?? this.slug,
      model: model ?? this.model,
    );
  }

  Future<List<Engine>> getEngines() async {
    return TypesAPI.getEngines(generation: this);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Generation) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      generationId.hashCode ^
      modelId.hashCode ^
      generationName.hashCode ^
      generationStatus.hashCode ^
      slug.hashCode ^
      model.hashCode;
}
