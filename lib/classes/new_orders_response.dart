import 'dart:convert';

import 'package:collection/collection.dart';

import 'order.dart';

class NewOrdersResponse {
  int? total;
  String? path;
  int? perPage;
  int? currentPage;
  int? from;
  int? to;
  String? prevPageUrl;
  String? nextPageUrl;
  int? firstPage;
  int? lastPage;
  List<Order>? data;

  NewOrdersResponse({
    this.total,
    this.path,
    this.perPage,
    this.currentPage,
    this.from,
    this.to,
    this.prevPageUrl,
    this.nextPageUrl,
    this.firstPage,
    this.lastPage,
    this.data,
  });

  @override
  String toString() {
    return 'NewOrdersResponse(total: $total, path: $path, perPage: $perPage, currentPage: $currentPage, from: $from, to: $to, prevPageUrl: $prevPageUrl, nextPageUrl: $nextPageUrl, firstPage: $firstPage, lastPage: $lastPage, data: $data)';
  }

  factory NewOrdersResponse.fromMap(Map<String, dynamic> data) {
    return NewOrdersResponse(
      total: data['total'] as int?,
      path: data['path'] as String?,
      perPage: data['per_page'] as int?,
      currentPage: data['current_page'] as int?,
      from: data['from'] as int?,
      to: data['to'] as int?,
      prevPageUrl: data['prev_page_url'] as String?,
      nextPageUrl: data['next_page_url'] as String?,
      firstPage: data['first_page'] as int?,
      lastPage: data['last_page'] as int?,
      data: (data['data'] as List<dynamic>?)
          ?.map((e) => Order.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

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
  /// Parses the string and returns the resulting Json object as [NewOrdersResponse].
  factory NewOrdersResponse.fromJson(String data) {
    return NewOrdersResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NewOrdersResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  NewOrdersResponse copyWith({
    int? total,
    String? path,
    int? perPage,
    int? currentPage,
    int? from,
    int? to,
    String? prevPageUrl,
    String? nextPageUrl,
    int? firstPage,
    int? lastPage,
    List<Order>? data,
  }) {
    return NewOrdersResponse(
      total: total ?? this.total,
      path: path ?? this.path,
      perPage: perPage ?? this.perPage,
      currentPage: currentPage ?? this.currentPage,
      from: from ?? this.from,
      to: to ?? this.to,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      firstPage: firstPage ?? this.firstPage,
      lastPage: lastPage ?? this.lastPage,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! NewOrdersResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
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
