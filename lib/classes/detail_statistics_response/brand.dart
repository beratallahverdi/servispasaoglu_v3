import 'dart:convert';

import 'package:collection/collection.dart';

class Brand {
  String? label;
  int? count;
  int? credit;

  Brand({this.label, this.count, this.credit});

  @override
  String toString() {
    return 'Brand(label: $label, count: $count, credit: $credit)';
  }

  factory Brand.fromMap(Map<String, dynamic> data) => Brand(
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
  /// Parses the string and returns the resulting Json object as [Brand].
  factory Brand.fromJson(String data) {
    return Brand.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Brand] to a JSON string.
  String toJson() => json.encode(toMap());

  Brand copyWith({
    String? label,
    int? count,
    int? credit,
  }) {
    return Brand(
      label: label ?? this.label,
      count: count ?? this.count,
      credit: credit ?? this.credit,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Brand) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => label.hashCode ^ count.hashCode ^ credit.hashCode;
}
