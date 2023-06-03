import 'dart:convert';

import 'package:collection/collection.dart';

class Torque {
	int? engineId;
	int? standard;
	int? stage1;
	int? stage2;
	int? stage3;

	Torque({
		this.engineId, 
		this.standard, 
		this.stage1, 
		this.stage2, 
		this.stage3, 
	});

	@override
	String toString() {
		return 'Torque(engineId: $engineId, standard: $standard, stage1: $stage1, stage2: $stage2, stage3: $stage3)';
	}

	factory Torque.fromMap(Map<String, dynamic> data) => Torque(
				engineId: data['engine_id'] as int?,
				standard: data['standard'] as int?,
				stage1: data['stage_1'] as int?,
				stage2: data['stage_2'] as int?,
				stage3: data['stage_3'] as int?,
			);

	Map<String, dynamic> toMap() => {
				'engine_id': engineId,
				'standard': standard,
				'stage_1': stage1,
				'stage_2': stage2,
				'stage_3': stage3,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Torque].
	factory Torque.fromJson(String data) {
		return Torque.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Torque] to a JSON string.
	String toJson() => json.encode(toMap());

	Torque copyWith({
		int? engineId,
		int? standard,
		int? stage1,
		int? stage2,
		int? stage3,
	}) {
		return Torque(
			engineId: engineId ?? this.engineId,
			standard: standard ?? this.standard,
			stage1: stage1 ?? this.stage1,
			stage2: stage2 ?? this.stage2,
			stage3: stage3 ?? this.stage3,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Torque) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			engineId.hashCode ^
			standard.hashCode ^
			stage1.hashCode ^
			stage2.hashCode ^
			stage3.hashCode;
}
