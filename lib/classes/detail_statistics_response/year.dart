import 'dart:convert';

import 'package:collection/collection.dart';

class Year {
  String? label;
  int? count;
  int? credit;

  Year({this.label, this.count, this.credit});

  @override
  String toString() => 'Year(label: $label, count: $count, credit: $credit)';

  factory Year.fromMap(Map<String, dynamic> data) => Year(
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
  /// Parses the string and returns the resulting Json object as [Year].
  factory Year.fromJson(String data) {
    return Year.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Year] to a JSON string.
  String toJson() => json.encode(toMap());

  Year copyWith({
    String? label,
    int? count,
    int? credit,
  }) {
    return Year(
      label: label ?? this.label,
      count: count ?? this.count,
      credit: credit ?? this.credit,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Year) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => label.hashCode ^ count.hashCode ^ credit.hashCode;
}
