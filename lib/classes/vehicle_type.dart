import 'dart:convert';

import 'package:collection/collection.dart';

class VehicleType {
	int? vehicleTypeId;
	String? type;
	String? createdAt;
	String? updatedAt;

	VehicleType({
		this.vehicleTypeId, 
		this.type, 
		this.createdAt, 
		this.updatedAt, 
	});

	@override
	String toString() {
		return 'VehicleType(vehicleTypeId: $vehicleTypeId, type: $type, createdAt: $createdAt, updatedAt: $updatedAt)';
	}

	factory VehicleType.fromMap(Map<String, dynamic> data) => VehicleType(
				vehicleTypeId: data['vehicle_type_id'] as int?,
				type: data['type'] as String?,
				createdAt: data['created_at'] as String?,
				updatedAt: data['updated_at'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'vehicle_type_id': vehicleTypeId,
				'type': type,
				'created_at': createdAt,
				'updated_at': updatedAt,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [VehicleType].
	factory VehicleType.fromJson(String data) {
		return VehicleType.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [VehicleType] to a JSON string.
	String toJson() => json.encode(toMap());

	VehicleType copyWith({
		int? vehicleTypeId,
		String? type,
		String? createdAt,
		String? updatedAt,
	}) {
		return VehicleType(
			vehicleTypeId: vehicleTypeId ?? this.vehicleTypeId,
			type: type ?? this.type,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! VehicleType) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			vehicleTypeId.hashCode ^
			type.hashCode ^
			createdAt.hashCode ^
			updatedAt.hashCode;
}
