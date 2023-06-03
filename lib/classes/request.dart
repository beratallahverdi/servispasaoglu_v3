import 'dart:convert';

import 'package:collection/collection.dart';

class Request {
	int? id;
	String? requestKey;
	String? description;
	int? credit;
	int? available;
	dynamic createdAt;
	String? updatedAt;

	Request({
		this.id, 
		this.requestKey, 
		this.description, 
		this.credit, 
		this.available, 
		this.createdAt, 
		this.updatedAt, 
	});

	@override
	String toString() {
		return 'Request(id: $id, requestKey: $requestKey, description: $description, credit: $credit, available: $available, createdAt: $createdAt, updatedAt: $updatedAt)';
	}

	factory Request.fromMap(Map<String, dynamic> data) => Request(
				id: data['id'] as int?,
				requestKey: data['request_key'] as String?,
				description: data['description'] as String?,
				credit: data['credit'] as int?,
				available: data['available'] as int?,
				createdAt: data['created_at'] as dynamic,
				updatedAt: data['updated_at'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'id': id,
				'request_key': requestKey,
				'description': description,
				'credit': credit,
				'available': available,
				'created_at': createdAt,
				'updated_at': updatedAt,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Request].
	factory Request.fromJson(String data) {
		return Request.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Request] to a JSON string.
	String toJson() => json.encode(toMap());

	Request copyWith({
		int? id,
		String? requestKey,
		String? description,
		int? credit,
		int? available,
		dynamic createdAt,
		String? updatedAt,
	}) {
		return Request(
			id: id ?? this.id,
			requestKey: requestKey ?? this.requestKey,
			description: description ?? this.description,
			credit: credit ?? this.credit,
			available: available ?? this.available,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Request) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			id.hashCode ^
			requestKey.hashCode ^
			description.hashCode ^
			credit.hashCode ^
			available.hashCode ^
			createdAt.hashCode ^
			updatedAt.hashCode;
}
