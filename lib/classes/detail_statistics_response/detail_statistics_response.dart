import 'dart:convert';

import 'package:collection/collection.dart';
import 'data.dart';

class DetailStatisticsResponse {
  String? status;
  Data? data;
  String? message;
  String? type;

  DetailStatisticsResponse({
    this.status,
    this.data,
    this.message,
    this.type,
  });

  @override
  String toString() {
    return 'DetailStatisticsResponse(status: $status, data: $data, message: $message, type: $type)';
  }

  factory DetailStatisticsResponse.fromMap(Map<String, dynamic> data) {
    return DetailStatisticsResponse(
      status: data['status'] as String?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
      message: data['message'] as String?,
      type: data['type'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.toMap(),
        'message': message,
        'type': type,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DetailStatisticsResponse].
  factory DetailStatisticsResponse.fromJson(String data) {
    return DetailStatisticsResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DetailStatisticsResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  DetailStatisticsResponse copyWith({
    String? status,
    Data? data,
    String? message,
    String? type,
  }) {
    return DetailStatisticsResponse(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DetailStatisticsResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      status.hashCode ^ data.hashCode ^ message.hashCode ^ type.hashCode;
}
