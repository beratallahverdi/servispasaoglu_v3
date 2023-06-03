import 'dart:convert';

import 'package:collection/collection.dart';

import 'status.dart';

class MessageStatusChange {
	int? messageStatusChangeId;
	int? messageId;
	int? messageStatus;
	String? createdAt;
	String? updatedAt;
	Status? status;

	MessageStatusChange({
		this.messageStatusChangeId, 
		this.messageId, 
		this.messageStatus, 
		this.createdAt, 
		this.updatedAt, 
		this.status, 
	});

	@override
	String toString() {
		return 'MessageStatusChange(messageStatusChangeId: $messageStatusChangeId, messageId: $messageId, messageStatus: $messageStatus, createdAt: $createdAt, updatedAt: $updatedAt, status: $status)';
	}

	factory MessageStatusChange.fromMap(Map<String, dynamic> data) {
		return MessageStatusChange(
			messageStatusChangeId: data['message_status_change_id'] as int?,
			messageId: data['message_id'] as int?,
			messageStatus: data['message_status'] as int?,
			createdAt: data['created_at'] as String?,
			updatedAt: data['updated_at'] as String?,
			status: data['status'] == null
						? null
						: Status.fromMap(data['status'] as Map<String, dynamic>),
		);
	}



	Map<String, dynamic> toMap() => {
				'message_status_change_id': messageStatusChangeId,
				'message_id': messageId,
				'message_status': messageStatus,
				'created_at': createdAt,
				'updated_at': updatedAt,
				'status': status?.toMap(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MessageStatusChange].
	factory MessageStatusChange.fromJson(String data) {
		return MessageStatusChange.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [MessageStatusChange] to a JSON string.
	String toJson() => json.encode(toMap());

	MessageStatusChange copyWith({
		int? messageStatusChangeId,
		int? messageId,
		int? messageStatus,
		String? createdAt,
		String? updatedAt,
		Status? status,
	}) {
		return MessageStatusChange(
			messageStatusChangeId: messageStatusChangeId ?? this.messageStatusChangeId,
			messageId: messageId ?? this.messageId,
			messageStatus: messageStatus ?? this.messageStatus,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
			status: status ?? this.status,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! MessageStatusChange) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			messageStatusChangeId.hashCode ^
			messageId.hashCode ^
			messageStatus.hashCode ^
			createdAt.hashCode ^
			updatedAt.hashCode ^
			status.hashCode;
}
