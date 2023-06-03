import 'dart:convert';

import 'package:collection/collection.dart';

class OrderStatusLog {
	int? orderStatusLogId;
	int? orderId;
	String? orderStatus;
	String? createdAt;
	String? updatedAt;

	OrderStatusLog({
		this.orderStatusLogId, 
		this.orderId, 
		this.orderStatus, 
		this.createdAt, 
		this.updatedAt, 
	});

	@override
	String toString() {
		return 'OrderStatusLog(orderStatusLogId: $orderStatusLogId, orderId: $orderId, orderStatus: $orderStatus, createdAt: $createdAt, updatedAt: $updatedAt)';
	}

	factory OrderStatusLog.fromMap(Map<String, dynamic> data) {
		return OrderStatusLog(
			orderStatusLogId: data['order_status_log_id'] as int?,
			orderId: data['order_id'] as int?,
			orderStatus: data['order_status'] as String?,
			createdAt: data['created_at'] as String?,
			updatedAt: data['updated_at'] as String?,
		);
	}



	Map<String, dynamic> toMap() => {
				'order_status_log_id': orderStatusLogId,
				'order_id': orderId,
				'order_status': orderStatus,
				'created_at': createdAt,
				'updated_at': updatedAt,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderStatusLog].
	factory OrderStatusLog.fromJson(String data) {
		return OrderStatusLog.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [OrderStatusLog] to a JSON string.
	String toJson() => json.encode(toMap());

	OrderStatusLog copyWith({
		int? orderStatusLogId,
		int? orderId,
		String? orderStatus,
		String? createdAt,
		String? updatedAt,
	}) {
		return OrderStatusLog(
			orderStatusLogId: orderStatusLogId ?? this.orderStatusLogId,
			orderId: orderId ?? this.orderId,
			orderStatus: orderStatus ?? this.orderStatus,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! OrderStatusLog) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			orderStatusLogId.hashCode ^
			orderId.hashCode ^
			orderStatus.hashCode ^
			createdAt.hashCode ^
			updatedAt.hashCode;
}
