import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:servispasaoglu_v3/api/response.dart';
import 'package:servispasaoglu_v3/utils/constants.dart';

class LoginAPI {
  static Future<ApiResponse> get(String authorization) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    var headers = {"Authorization": authorization, "FCM-Token": "$fcmToken"};
    var uri = ServisPasaogluConstants.baseUrl;
    final response = await http.get(Uri.https(uri, '/login'), headers: headers);
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
