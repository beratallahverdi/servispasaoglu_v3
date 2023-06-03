import 'dart:convert';

import 'package:collection/collection.dart';

class MessageStatus {
	int? messageStatusId;
	String? status;

	MessageStatus({this.messageStatusId, this.status});

	@override
	String toString() {
		return 'MessageStatus(messageStatusId: $messageStatusId, status: $status)';
	}

	factory MessageStatus.fromMap(Map<String, dynamic> data) => MessageStatus(
				messageStatusId: data['message_status_id'] as int?,
				status: data['status'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'message_status_id': messageStatusId,
				'status': status,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MessageStatus].
	factory MessageStatus.fromJson(String data) {
		return MessageStatus.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [MessageStatus] to a JSON string.
	String toJson() => json.encode(toMap());

	MessageStatus copyWith({
		int? messageStatusId,
		String? status,
	}) {
		return MessageStatus(
			messageStatusId: messageStatusId ?? this.messageStatusId,
			status: status ?? this.status,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! MessageStatus) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => messageStatusId.hashCode ^ status.hashCode;
}
