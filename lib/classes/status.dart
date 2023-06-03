import 'dart:convert';

import 'package:collection/collection.dart';

class Status {
	int? messageStatusId;
	String? status;

	Status({this.messageStatusId, this.status});

	@override
	String toString() {
		return 'Status(messageStatusId: $messageStatusId, status: $status)';
	}

	factory Status.fromMap(Map<String, dynamic> data) => Status(
				messageStatusId: data['message_status_id'] as int?,
				status: data['status'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'message_status_id': messageStatusId,
				'status': status,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Status].
	factory Status.fromJson(String data) {
		return Status.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Status] to a JSON string.
	String toJson() => json.encode(toMap());

	Status copyWith({
		int? messageStatusId,
		String? status,
	}) {
		return Status(
			messageStatusId: messageStatusId ?? this.messageStatusId,
			status: status ?? this.status,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Status) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => messageStatusId.hashCode ^ status.hashCode;
}
