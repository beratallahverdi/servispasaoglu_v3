import 'dart:convert';

import 'package:collection/collection.dart';

class ReadMethod {
	int? readMethodId;
	String? brand;
	String? type;
	String? name;
	int? laravelThroughKey;

	ReadMethod({
		this.readMethodId, 
		this.brand, 
		this.type, 
		this.name, 
		this.laravelThroughKey, 
	});

	@override
	String toString() {
		return 'ReadMethod(readMethodId: $readMethodId, brand: $brand, type: $type, name: $name, laravelThroughKey: $laravelThroughKey)';
	}

	factory ReadMethod.fromMap(Map<String, dynamic> data) => ReadMethod(
				readMethodId: data['read_method_id'] as int?,
				brand: data['brand'] as String?,
				type: data['type'] as String?,
				name: data['name'] as String?,
				laravelThroughKey: data['laravel_through_key'] as int?,
			);

	Map<String, dynamic> toMap() => {
				'read_method_id': readMethodId,
				'brand': brand,
				'type': type,
				'name': name,
				'laravel_through_key': laravelThroughKey,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ReadMethod].
	factory ReadMethod.fromJson(String data) {
		return ReadMethod.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [ReadMethod] to a JSON string.
	String toJson() => json.encode(toMap());

	ReadMethod copyWith({
		int? readMethodId,
		String? brand,
		String? type,
		String? name,
		int? laravelThroughKey,
	}) {
		return ReadMethod(
			readMethodId: readMethodId ?? this.readMethodId,
			brand: brand ?? this.brand,
			type: type ?? this.type,
			name: name ?? this.name,
			laravelThroughKey: laravelThroughKey ?? this.laravelThroughKey,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! ReadMethod) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			readMethodId.hashCode ^
			brand.hashCode ^
			type.hashCode ^
			name.hashCode ^
			laravelThroughKey.hashCode;
}
