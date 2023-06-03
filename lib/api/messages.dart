import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:servispasaoglu_v3/api/response.dart';
import 'package:servispasaoglu_v3/classes/message.dart';
import 'package:servispasaoglu_v3/utils/constants.dart';
import 'package:servispasaoglu_v3/utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagesAPI {
  static Future<ApiResponse> get(id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    final response =
        await http.get(Uri.https(uri, "/api/messages/$id"), headers: headers);
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> newStore(int orderId, {text, image, video}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;

    var request =
        http.MultipartRequest('POST', Uri.https(uri, '/api/messages/$orderId'));
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image));
    }
    request.headers.addAll(headers);
    request.fields.addAll({
      "text": (text != "" && text != null) ? text : "",
    });
    await request.send();
    final response = await http.post(
        Uri.https(uri, "/api/messages/$orderId", {"text": null}),
        headers: headers);

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> store(String message, int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    final response = await http.post(Uri.https(uri, "/api/messages/$id"),
        body: <String, String>{
          "message": message,
        },
        headers: headers);
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<void> setDelivered(int orderId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    final response = await http.get(
        Uri.https(uri, "/api/notifications/delivered/$orderId"),
        headers: headers);
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<File> download(Message message) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
      Uri.https(uri, '/api/v1/downloads/file',
          {'orderId': "${message.orderId}", 'fileName': "${message.file}"}),
      headers: headers,
    );
    return ServisPasaogluFunctions.responseSave(response).then((file) => file);
  }
}
