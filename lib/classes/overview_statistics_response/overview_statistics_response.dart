import 'dart:convert';

import 'package:collection/collection.dart';

import 'datum.dart';

class OverviewStatisticsResponse {
  String? status;
  List<Datum>? data;
  String? message;
  String? type;

  OverviewStatisticsResponse({
    this.status,
    this.data,
    this.message,
    this.type,
  });

  @override
  String toString() {
    return 'OverviewStatisticsResponse(status: $status, data: $data, message: $message, type: $type)';
  }

  factory OverviewStatisticsResponse.fromMap(Map<String, dynamic> data) {
    return OverviewStatisticsResponse(
      status: data['status'] as String?,
      data: (data['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
          .toList(),
      message: data['message'] as String?,
      type: data['type'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
        'message': message,
        'type': type,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OverviewStatisticsResponse].
  factory OverviewStatisticsResponse.fromJson(String data) {
    return OverviewStatisticsResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OverviewStatisticsResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  OverviewStatisticsResponse copyWith({
    String? status,
    List<Datum>? data,
    String? message,
    String? type,
  }) {
    return OverviewStatisticsResponse(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OverviewStatisticsResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      status.hashCode ^ data.hashCode ^ message.hashCode ^ type.hashCode;
}
