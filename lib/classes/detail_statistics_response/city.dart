import 'dart:convert';

import 'package:collection/collection.dart';

class City {
  String? label;
  int? count;
  int? credit;

  City({this.label, this.count, this.credit});

  @override
  String toString() => 'City(label: $label, count: $count, credit: $credit)';

  factory City.fromMap(Map<String, dynamic> data) => City(
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
  /// Parses the string and returns the resulting Json object as [City].
  factory City.fromJson(String data) {
    return City.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [City] to a JSON string.
  String toJson() => json.encode(toMap());

  City copyWith({
    String? label,
    int? count,
    int? credit,
  }) {
    return City(
      label: label ?? this.label,
      count: count ?? this.count,
      credit: credit ?? this.credit,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! City) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => label.hashCode ^ count.hashCode ^ credit.hashCode;
}
