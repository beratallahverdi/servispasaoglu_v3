import 'dart:convert';

import 'package:collection/collection.dart';

class Month {
  String? label;
  int? count;
  int? credit;

  Month({this.label, this.count, this.credit});

  @override
  String toString() {
    return 'Month(label: $label, count: $count, credit: $credit)';
  }

  factory Month.fromMap(Map<String, dynamic> data) => Month(
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
  /// Parses the string and returns the resulting Json object as [Month].
  factory Month.fromJson(String data) {
    return Month.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Month] to a JSON string.
  String toJson() => json.encode(toMap());

  Month copyWith({
    String? label,
    int? count,
    int? credit,
  }) {
    return Month(
      label: label ?? this.label,
      count: count ?? this.count,
      credit: credit ?? this.credit,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Month) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => label.hashCode ^ count.hashCode ^ credit.hashCode;
}
