import 'dart:convert';

import 'package:collection/collection.dart';

import 'request.dart';

class OrderRequest {
	int? orderRequestId;
	int? orderId;
	int? requestId;
	String? createdAt;
	String? updatedAt;
	int? isComplete;
	int? credit;
	Request? request;

	OrderRequest({
		this.orderRequestId, 
		this.orderId, 
		this.requestId, 
		this.createdAt, 
		this.updatedAt, 
		this.isComplete, 
		this.credit, 
		this.request, 
	});

	@override
	String toString() {
		return 'OrderRequest(orderRequestId: $orderRequestId, orderId: $orderId, requestId: $requestId, createdAt: $createdAt, updatedAt: $updatedAt, isComplete: $isComplete, credit: $credit, request: $request)';
	}

	factory OrderRequest.fromMap(Map<String, dynamic> data) => OrderRequest(
				orderRequestId: data['order_request_id'] as int?,
				orderId: data['order_id'] as int?,
				requestId: data['request_id'] as int?,
				createdAt: data['created_at'] as String?,
				updatedAt: data['updated_at'] as String?,
				isComplete: data['is_complete'] as int?,
				credit: data['credit'] as int?,
				request: data['request'] == null
						? null
						: Request.fromMap(data['request'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toMap() => {
				'order_request_id': orderRequestId,
				'order_id': orderId,
				'request_id': requestId,
				'created_at': createdAt,
				'updated_at': updatedAt,
				'is_complete': isComplete,
				'credit': credit,
				'request': request?.toMap(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderRequest].
	factory OrderRequest.fromJson(String data) {
		return OrderRequest.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [OrderRequest] to a JSON string.
	String toJson() => json.encode(toMap());

	OrderRequest copyWith({
		int? orderRequestId,
		int? orderId,
		int? requestId,
		String? createdAt,
		String? updatedAt,
		int? isComplete,
		int? credit,
		Request? request,
	}) {
		return OrderRequest(
			orderRequestId: orderRequestId ?? this.orderRequestId,
			orderId: orderId ?? this.orderId,
			requestId: requestId ?? this.requestId,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
			isComplete: isComplete ?? this.isComplete,
			credit: credit ?? this.credit,
			request: request ?? this.request,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! OrderRequest) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			orderRequestId.hashCode ^
			orderId.hashCode ^
			requestId.hashCode ^
			createdAt.hashCode ^
			updatedAt.hashCode ^
			isComplete.hashCode ^
			credit.hashCode ^
			request.hashCode;
}
