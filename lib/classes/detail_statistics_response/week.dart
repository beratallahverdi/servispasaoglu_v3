import 'dart:convert';

import 'package:collection/collection.dart';

class Week {
  String? label;
  int? count;
  int? credit;

  Week({this.label, this.count, this.credit});

  @override
  String toString() => 'Week(label: $label, count: $count, credit: $credit)';

  factory Week.fromMap(Map<String, dynamic> data) => Week(
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
  /// Parses the string and returns the resulting Json object as [Week].
  factory Week.fromJson(String data) {
    return Week.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Week] to a JSON string.
  String toJson() => json.encode(toMap());

  Week copyWith({
    String? label,
    int? count,
    int? credit,
  }) {
    return Week(
      label: label ?? this.label,
      count: count ?? this.count,
      credit: credit ?? this.credit,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Week) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => label.hashCode ^ count.hashCode ^ credit.hashCode;
}
