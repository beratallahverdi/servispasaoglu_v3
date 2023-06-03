import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:servispasaoglu_v3/classes/order.dart';

@immutable
class OrdersResponse {
  final int total;
  final String path;
  final int perPage;
  final int currentPage;
  final int from;
  final int to;
  final String prevPageUrl;
  final String nextPageUrl;
  final int firstPage;
  final int lastPage;
  final List<Order>? data;

  const OrdersResponse({
    this.data,
    required this.total,
    required this.path,
    required this.perPage,
    required this.currentPage,
    required this.from,
    required this.to,
    required this.prevPageUrl,
    required this.nextPageUrl,
    required this.firstPage,
    required this.lastPage,
  });

  @override
  String toString() {
    return 'OrdersResponse(total: $total, path: $path, perPage: $perPage, currentPage: $currentPage, from: $from, to: $to, prevPageUrl: $prevPageUrl,nextPageUrl: $nextPageUrl, firstPage: $firstPage, lastPage: $lastPage, data: $data,)';
  }

  factory OrdersResponse.fromMap(Map<String, dynamic> data) => OrdersResponse(
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => Order.fromMap(e as Map<String, dynamic>))
            .toList(),
        total: data['total'] as int,
        path: data['path'] as String,
        perPage: data['per_page'] as int,
        currentPage: data['current_page'] as int,
        from: int.parse("${data['from']}"),
        to: int.parse("${data['to']}"),
        prevPageUrl: data['prev_page_url'] as String,
        nextPageUrl: data['next_page_url'] as String,
        firstPage: data['first_page'] as int,
        lastPage: data['last_page'] as int,
      );

  Map<String, dynamic> toMap() => {
        'total': total,
        'path': path,
        'per_page': perPage,
        'current_page': currentPage,
        'from': from,
        'to': to,
        'prev_page_url': prevPageUrl,
        'next_page_url': nextPageUrl,
        'first_page': firstPage,
        'last_page': lastPage,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrdersResponse].
  factory OrdersResponse.fromJson(String data) {
    return OrdersResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrdersResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OrdersResponse) return false;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      total.hashCode ^
      path.hashCode ^
      perPage.hashCode ^
      currentPage.hashCode ^
      from.hashCode ^
      to.hashCode ^
      prevPageUrl.hashCode ^
      nextPageUrl.hashCode ^
      firstPage.hashCode ^
      lastPage.hashCode ^
      data.hashCode;
}
