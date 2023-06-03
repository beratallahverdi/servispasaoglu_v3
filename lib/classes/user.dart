import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:servispasaoglu_v3/api/users.dart';
import 'package:servispasaoglu_v3/classes/order.dart';
import 'package:servispasaoglu_v3/screens/Users/user_details.dart';

import 'store.dart';

class User {
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  Store? store;
  List<dynamic>? tuningDevices;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.store,
    this.tuningDevices,
  });

  @override
  String toString() {
    return 'User(userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, store: $store, tuningDevices: $tuningDevices)';
  }

  factory User.fromMap(Map<String, dynamic> data) => User(
        userId: data['user_id'] as int?,
        firstName: data['first_name'] as String?,
        lastName: data['last_name'] as String?,
        email: data['email'] as String?,
        phoneNumber: data['phone_number'] as String?,
        store: data['store'] == null
            ? null
            : Store.fromMap(data['store'] as Map<String, dynamic>),
        tuningDevices: data['tuning_devices'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'user_id': userId,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phoneNumber,
        'store': store?.toMap(),
        'tuning_devices': tuningDevices,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());

  User copyWith({
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    Store? store,
    List<dynamic>? tuningDevices,
  }) {
    return User(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      store: store ?? this.store,
      tuningDevices: tuningDevices ?? this.tuningDevices,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! User) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      userId.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      store.hashCode ^
      tuningDevices.hashCode;

  Future<List<int>> access(Order order) async {
    return await UsersAPI.sendAccess(this, order);
  }

  Future<User> update() async {
    return await UsersAPI.updateUser(this);
  }

  Widget card(BuildContext context) {
    return Card(
        elevation: 2,
        child: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserDetails(selectedUser: this))),
            child: ListTile(
              title: Text("${store!.city!} - ${store!.sellerName}"),
              subtitle: Text("$firstName $lastName"),
            )));
  }
}
