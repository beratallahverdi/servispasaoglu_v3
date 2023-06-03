import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:servispasaoglu_v3/classes/order.dart';

@immutable
class OrderResponse {
  final String? status;
  final Order? order;
  final String? message;
  final String? type;

  const OrderResponse({this.status, this.order, this.message, this.type});

  @override
  String toString() {
    return 'OrderResponse(status: $status, data: $order, message: $message, type: $type)';
  }

  factory OrderResponse.fromMap(Map<String, dynamic> data) => OrderResponse(
        status: data['status'] as String?,
        order: data['data'] == null
            ? null
            : Order.fromMap(data['data'] as Map<String, dynamic>),
        message: data['message'] as String?,
        type: data['type'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': order?.toMap(),
        'message': message,
        'type': type,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderResponse].
  factory OrderResponse.fromJson(String data) {
    return OrderResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  OrderResponse copyWith({
    String? status,
    Order? order,
    String? message,
    String? type,
  }) {
    return OrderResponse(
      status: status ?? this.status,
      order: order ?? this.order,
      message: message ?? this.message,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OrderResponse) return false;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      status.hashCode ^ order.hashCode ^ message.hashCode ^ type.hashCode;
}
