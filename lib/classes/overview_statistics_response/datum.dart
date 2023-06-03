import 'dart:convert';

import 'package:collection/collection.dart';

import 'order_status.dart';

class Datum {
  OrderStatus? orderStatus;
  String? status;
  int? count;
  String? credit;

  Datum({this.orderStatus, this.status, this.count, this.credit});

  @override
  String toString() {
    return 'Datum(orderStatus: $orderStatus, status: $status, count: $count, credit: $credit)';
  }

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
      orderStatus: data['order_status'] == null
          ? null
          : OrderStatus.fromMap(data['order_status'] as Map<String, dynamic>),
      status: data['status'] as String?,
      count: data['count'] as int?,
      credit: "${data['credit']}");

  Map<String, dynamic> toMap() => {
        'order_status': orderStatus?.toMap(),
        'status': status,
        'count': count,
        'credit': credit,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) {
    return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());

  Datum copyWith({
    OrderStatus? orderStatus,
    String? status,
    int? count,
    String? credit,
  }) {
    return Datum(
      orderStatus: orderStatus ?? this.orderStatus,
      status: status ?? this.status,
      count: count ?? this.count,
      credit: credit ?? this.credit,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Datum) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      orderStatus.hashCode ^ status.hashCode ^ count.hashCode ^ credit.hashCode;
}
