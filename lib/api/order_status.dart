import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:servispasaoglu_v3/api/response.dart';
import 'package:servispasaoglu_v3/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderStatusesAPI {
  static Future<ApiResponse> get() async {
    const String apiLink = '/api/order-status';

    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(Uri.https(uri, apiLink), headers: headers);
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
