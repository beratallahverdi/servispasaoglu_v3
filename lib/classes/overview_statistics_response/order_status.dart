import 'dart:convert';

import 'package:collection/collection.dart';

class OrderStatus {
  int? id;
  String? orderStatusKey;
  String? description;
  String? html;
  String? chartColor;
  String? createdAt;

  OrderStatus({
    this.id,
    this.orderStatusKey,
    this.description,
    this.html,
    this.chartColor,
    this.createdAt,
  });

  @override
  String toString() {
    return 'OrderStatus(id: $id, orderStatusKey: $orderStatusKey, description: $description, html: $html, chartColor: $chartColor, createdAt: $createdAt)';
  }

  factory OrderStatus.fromMap(Map<String, dynamic> data) => OrderStatus(
        id: data['id'] as int?,
        orderStatusKey: data['order_status_key'] as String?,
        description: data['description'] as String?,
        html: data['html'] as String?,
        chartColor: data['chart_color'] as String?,
        createdAt: data['created_at'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'order_status_key': orderStatusKey,
        'description': description,
        'html': html,
        'chart_color': chartColor,
        'created_at': createdAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderStatus].
  factory OrderStatus.fromJson(String data) {
    return OrderStatus.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderStatus] to a JSON string.
  String toJson() => json.encode(toMap());

  OrderStatus copyWith({
    int? id,
    String? orderStatusKey,
    String? description,
    String? html,
    String? chartColor,
    String? createdAt,
  }) {
    return OrderStatus(
      id: id ?? this.id,
      orderStatusKey: orderStatusKey ?? this.orderStatusKey,
      description: description ?? this.description,
      html: html ?? this.html,
      chartColor: chartColor ?? this.chartColor,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OrderStatus) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      orderStatusKey.hashCode ^
      description.hashCode ^
      html.hashCode ^
      chartColor.hashCode ^
      createdAt.hashCode;
}
