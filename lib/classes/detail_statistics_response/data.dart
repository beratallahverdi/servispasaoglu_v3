import 'dart:convert';

import 'package:collection/collection.dart';

import 'brand.dart';
import 'city.dart';
import 'day.dart';
import 'month.dart';
import 'request.dart';
import 'week.dart';
import 'year.dart';

class Data {
  List<Day>? days;
  List<Week>? weeks;
  List<Month>? months;
  List<Year>? years;
  List<Brand>? brands;
  List<Request>? requests;
  List<City>? cities;

  Data({
    this.days,
    this.weeks,
    this.months,
    this.years,
    this.brands,
    this.requests,
    this.cities,
  });

  @override
  String toString() {
    return 'Data(days: $days, weeks: $weeks, months: $months, years: $years, brands: $brands, requests: $requests, cities: $cities)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        days: (data['days'] as List<dynamic>?)
            ?.map((e) => Day.fromMap(e as Map<String, dynamic>))
            .toList(),
        weeks: (data['weeks'] as List<dynamic>?)
            ?.map((e) => Week.fromMap(e as Map<String, dynamic>))
            .toList(),
        months: (data['months'] as List<dynamic>?)
            ?.map((e) => Month.fromMap(e as Map<String, dynamic>))
            .toList(),
        years: (data['years'] as List<dynamic>?)
            ?.map((e) => Year.fromMap(e as Map<String, dynamic>))
            .toList(),
        brands: (data['brands'] as List<dynamic>?)
            ?.map((e) => Brand.fromMap(e as Map<String, dynamic>))
            .toList(),
        requests: (data['requests'] as List<dynamic>?)
            ?.map((e) => Request.fromMap(e as Map<String, dynamic>))
            .toList(),
        cities: (data['cities'] as List<dynamic>?)
            ?.map((e) => City.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'days': days?.map((e) => e.toMap()).toList(),
        'weeks': weeks?.map((e) => e.toMap()).toList(),
        'months': months?.map((e) => e.toMap()).toList(),
        'years': years?.map((e) => e.toMap()).toList(),
        'brands': brands?.map((e) => e.toMap()).toList(),
        'requests': requests?.map((e) => e.toMap()).toList(),
        'cities': cities?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    List<Day>? days,
    List<Week>? weeks,
    List<Month>? months,
    List<Year>? years,
    List<Brand>? brands,
    List<Request>? requests,
    List<City>? cities,
  }) {
    return Data(
      days: days ?? this.days,
      weeks: weeks ?? this.weeks,
      months: months ?? this.months,
      years: years ?? this.years,
      brands: brands ?? this.brands,
      requests: requests ?? this.requests,
      cities: cities ?? this.cities,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      days.hashCode ^
      weeks.hashCode ^
      months.hashCode ^
      years.hashCode ^
      brands.hashCode ^
      requests.hashCode ^
      cities.hashCode;
}
