import 'dart:convert';

import 'package:collection/collection.dart';

class Day {
  String? label;
  int? count;
  int? credit;

  Day({this.label, this.count, this.credit});

  @override
  String toString() => 'Day(label: $label, count: $count, credit: $credit)';

  factory Day.fromMap(Map<String, dynamic> data) => Day(
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
  /// Parses the string and returns the resulting Json object as [Day].
  factory Day.fromJson(String data) {
    return Day.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Day] to a JSON string.
  String toJson() => json.encode(toMap());

  Day copyWith({
    String? label,
    int? count,
    int? credit,
  }) {
    return Day(
      label: label ?? this.label,
      count: count ?? this.count,
      credit: credit ?? this.credit,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Day) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => label.hashCode ^ count.hashCode ^ credit.hashCode;
}
