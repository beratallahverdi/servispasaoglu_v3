import 'dart:convert';

import 'package:collection/collection.dart';

import 'types_data.dart';

class TypeResponse {
  String? status;
  TypesData? data;
  String? type;

  TypeResponse({this.status, this.data, this.type});

  @override
  String toString() {
    return 'TypeResponse(status: $status, data: $data, type: $type)';
  }

  factory TypeResponse.fromMap(Map<String, dynamic> data) => TypeResponse(
        status: data['status'] as String?,
        data: data['data'] == null
            ? null
            : TypesData.fromMap(data['data'] as Map<String, dynamic>),
        type: data['type'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.toMap(),
        'type': type,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TypeResponse].
  factory TypeResponse.fromJson(String data) {
    return TypeResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TypeResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  TypeResponse copyWith({
    String? status,
    TypesData? data,
    String? type,
  }) {
    return TypeResponse(
      status: status ?? this.status,
      data: data ?? this.data,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TypeResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode ^ type.hashCode;
}
