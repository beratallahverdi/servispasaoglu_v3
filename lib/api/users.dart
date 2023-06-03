import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:servispasaoglu_v3/classes/order.dart';
import 'package:servispasaoglu_v3/classes/user.dart';
import 'package:servispasaoglu_v3/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersAPI {
  static Future<List<User>> get() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
      Uri.https(uri, '/api/v1/users'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return (json.decode(response.body)['data'] as List)
          .map((e) => User.fromMap(e))
          .toList()
        ..sort((a, b) => a.firstName!.compareTo(b.lastName!))
        ..sort((a, b) => a.store!.city!.compareTo(b.store!.city!));
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<List<int>> sendAccess(User user, Order order) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.post(
      Uri.https(uri, "/api/v1/orders/${order.orderId}/access"),
      headers: headers,
      body: jsonEncode({"user_id": user.userId}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'] as List<int>;
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<User> updateUser(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.put(
      Uri.https(uri, "/api/v1/users/${user.userId}"),
      headers: headers,
      body: jsonEncode({
        "first_name": user.firstName,
        "last_name": user.lastName,
        "phone_number": user.phoneNumber,
        "email": user.email,
        "seller_name": user.store!.sellerName,
        "seller_phone": user.store!.sellerPhone,
        "seller_email": user.store!.sellerEmail,
        "seller_address": user.store!.sellerAddress,
        "city": user.store!.city,
        "country": user.store!.country,
        "seller_credit": user.store!.sellerCredit,
      }),
    );
    if (response.statusCode == 200) {
      return User.fromMap(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to update user');
    }
  }

  static Future<bool> sendAccessByOrderId(User user, int orderId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.post(
      Uri.https(uri, "/api/v1/orders/$orderId/access"),
      headers: headers,
      body: jsonEncode({"user_id": user.userId}),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<void> setQuickLookDays(int value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
      Uri.https(uri, '/api/v1/users/changeQuickLookDates', {"days": "$value"}),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to set days');
    }
  }
}
