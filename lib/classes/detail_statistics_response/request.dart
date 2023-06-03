import 'dart:convert';

import 'package:collection/collection.dart';

class Request {
  String? label;
  int? count;
  int? credit;

  Request({this.label, this.count, this.credit});

  @override
  String toString() {
    return 'Request(label: $label, count: $count, credit: $credit)';
  }

  factory Request.fromMap(Map<String, dynamic> data) => Request(
        label: data['label'] as String?,
        count: data['count'] as int?,
        credit: data['credit'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'label': label,
        'count': count,
        'credit': credit,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Request].
  factory Request.fromJson(String data) {
    return Request.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Request] to a JSON string.
  String toJson() => json.encode(toMap());

  Request copyWith({
    String? label,
    int? count,
    int? credit,
  }) {
    return Request(
      label: label ?? this.label,
      count: count ?? this.count,
      credit: credit ?? this.credit,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Request) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => label.hashCode ^ count.hashCode ^ credit.hashCode;
}
