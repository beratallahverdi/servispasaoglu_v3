import 'dart:convert';

import 'package:collection/collection.dart';

class RequestsWithOrderRequest {
  int? available;
  int? completed;
  int? credit;
  String? description;
  int? id;
  String? requestKey;
  int? selected;

  RequestsWithOrderRequest({
    this.available,
    this.completed,
    this.credit,
    this.description,
    this.id,
    this.requestKey,
    this.selected,
  });

  @override
  String toString() {
    return 'OrderRequests(available: $available, completed: $completed, credit: $credit, description: $description, id: $id, requestKey: $requestKey, selected: $selected)';
  }

  factory RequestsWithOrderRequest.fromMap(Map<String, dynamic> data) =>
      RequestsWithOrderRequest(
        available: data['available'] as int?,
        completed: data['completed'] as int?,
        credit: data['credit'] as int?,
        description: data['description'] as String?,
        id: data['id'] as int?,
        requestKey: data['request_key'] as String?,
        selected: data['selected'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'available': available,
        'completed': completed,
        'credit': credit,
        'description': description,
        'id': id,
        'request_key': requestKey,
        'selected': selected,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderRequests].
  factory RequestsWithOrderRequest.fromJson(String data) {
    return RequestsWithOrderRequest.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderRequests] to a JSON string.
  String toJson() => json.encode(toMap());

  RequestsWithOrderRequest copyWith({
    int? available,
    int? completed,
    int? credit,
    String? description,
    int? id,
    String? requestKey,
    int? selected,
  }) {
    return RequestsWithOrderRequest(
      available: available ?? this.available,
      completed: completed ?? this.completed,
      credit: credit ?? this.credit,
      description: description ?? this.description,
      id: id ?? this.id,
      requestKey: requestKey ?? this.requestKey,
      selected: selected ?? this.selected,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RequestsWithOrderRequest) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      available.hashCode ^
      completed.hashCode ^
      credit.hashCode ^
      description.hashCode ^
      id.hashCode ^
      requestKey.hashCode ^
      selected.hashCode;
}
