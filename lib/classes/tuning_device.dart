import 'dart:convert';

import 'package:collection/collection.dart';

class TuningDevice {
	int? id;
	String? group;
	String? deviceKey;
	String? description;
	int? available;
	dynamic createdAt;
	dynamic updatedAt;

	TuningDevice({
		this.id, 
		this.group, 
		this.deviceKey, 
		this.description, 
		this.available, 
		this.createdAt, 
		this.updatedAt, 
	});

	@override
	String toString() {
		return 'TuningDevice(id: $id, group: $group, deviceKey: $deviceKey, description: $description, available: $available, createdAt: $createdAt, updatedAt: $updatedAt)';
	}

	factory TuningDevice.fromMap(Map<String, dynamic> data) => TuningDevice(
				id: data['id'] as int?,
				group: data['group'] as String?,
				deviceKey: data['device_key'] as String?,
				description: data['description'] as String?,
				available: data['available'] as int?,
				createdAt: data['created_at'] as dynamic,
				updatedAt: data['updated_at'] as dynamic,
			);

	Map<String, dynamic> toMap() => {
				'id': id,
				'group': group,
				'device_key': deviceKey,
				'description': description,
				'available': available,
				'created_at': createdAt,
				'updated_at': updatedAt,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TuningDevice].
	factory TuningDevice.fromJson(String data) {
		return TuningDevice.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [TuningDevice] to a JSON string.
	String toJson() => json.encode(toMap());

	TuningDevice copyWith({
		int? id,
		String? group,
		String? deviceKey,
		String? description,
		int? available,
		dynamic createdAt,
		dynamic updatedAt,
	}) {
		return TuningDevice(
			id: id ?? this.id,
			group: group ?? this.group,
			deviceKey: deviceKey ?? this.deviceKey,
			description: description ?? this.description,
			available: available ?? this.available,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! TuningDevice) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			id.hashCode ^
			group.hashCode ^
			deviceKey.hashCode ^
			description.hashCode ^
			available.hashCode ^
			createdAt.hashCode ^
			updatedAt.hashCode;
}
