import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:servispasaoglu_v3/api/response.dart';
import 'package:servispasaoglu_v3/classes/detail_statistics_response/detail_statistics_response.dart';
import 'package:servispasaoglu_v3/classes/order.dart';
import 'package:servispasaoglu_v3/classes/order_response.dart';
import 'package:servispasaoglu_v3/classes/order_status.dart';
import 'package:servispasaoglu_v3/classes/orders_response.dart';
import 'package:servispasaoglu_v3/classes/overview_statistics_response/overview_statistics_response.dart';
import 'package:servispasaoglu_v3/classes/requests_with_order_request.dart';
import 'package:servispasaoglu_v3/classes/type_response.dart';
import 'package:servispasaoglu_v3/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersAPI {
  static Future<OrderResponse> get(Order order) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
      Uri.https(uri, '/api/v1/orders/${order.orderId}'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return OrderResponse.fromJson(response.body);
    } else {
      throw Exception('Fail to get order');
    }
  }

  static Future<OrderResponse> save(
      {Order? order, Map<String, dynamic>? data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    try {
      var response = await http.put(Uri.https(uri, '/api/v1/orders/test'),
          headers: headers, body: jsonEncode(data));
      if (response.statusCode == 200) {
        return OrderResponse.fromJson(response.body);
      } else {
        throw Exception('Fail to get order');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<OrdersResponse> getWithPage({page = 0, limit = 50}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
        Uri.https(uri, '/api/v1/orders', {
          "page": page.toString(),
          "limit": limit.toString(),
        }),
        headers: headers);
    if (response.statusCode == 200) {
      return OrdersResponse.fromJson(response.body);
    } else {
      throw Exception('Fail to load orders');
    }
  }

  static Future<OrdersResponse> getWithOffset({offset = 0, limit = 10}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
        Uri.https(uri, '/api/v1/orders', {
          "offset": offset.toString(),
          "limit": limit.toString(),
        }),
        headers: headers);
    if (response.statusCode == 200) {
      return OrdersResponse.fromJson(response.body);
    } else {
      throw Exception('Fail to load orders');
    }
  }

  static Future<OrdersResponse> getWithKeyword(
      {keyword = '', page = 1, limit = 50}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
        Uri.https(uri,
            '/api/v1/orders/search/keyword/${Uri.encodeComponent(keyword)}', {
          "page": page.toString(),
          "limit": limit.toString(),
        }),
        headers: headers);
    if (response.statusCode == 200) {
      return OrdersResponse.fromJson(response.body);
    } else {
      throw Exception('Fail to load orders');
    }
  }

  static Future<OrderResponse> set(Order order,
      {String status = OrderStatus.waiting}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.put(
        Uri.https(uri, '/api/v1/orders/${order.orderId}'),
        headers: headers,
        body: jsonEncode({"order_status": status}));
    if (response.statusCode == 200) {
      return OrderResponse.fromJson(response.body);
    } else {
      throw Exception('Fail to set status');
    }
  }

  static Future<TypeResponse> typesGetFromOrder(Order order) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
      Uri.https(uri, '/api/v1/types/${order.orderId}'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return TypeResponse.fromJson(response.body);
    } else {
      throw Exception('Fail to get types');
    }
  }

  static Future<List<RequestsWithOrderRequest>> getRequestsWithOrder(
      Order order) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
      Uri.https(uri, '/api/v1/requests/${order.orderId}'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return (json.decode(response.body)['data'] as List)
          .map((e) => RequestsWithOrderRequest.fromMap(e))
          .toList();
    } else {
      throw Exception('Fail to get order requests');
    }
  }

  static Future<OrderResponse> sendMessage(Order order,
      {String? text,
      FilePickerResult? files,
      XFile? photo,
      String? microphone}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var request = http.MultipartRequest(
        "POST",
        Uri.https(ServisPasaogluConstants.baseUrl,
            '/api/v1/messages/${order.orderId}'));
    request.headers.addAll(headers);
    request.fields
        .update("text", (value) => text ?? "", ifAbsent: () => text ?? "");
    if (files != null) {
      for (var file in files.files) {
        request.files.add(await http.MultipartFile.fromPath(
            'files[]', file.path!,
            filename: file.name));
      }
    }
    if (photo != null) {
      photo.readAsBytes().then((value) => request.files.add(
          http.MultipartFile.fromBytes('files[]', value,
              filename: photo.path)));
    }
    if (microphone != null) {
      DateTime current = DateTime.now();
      request.files.add(await http.MultipartFile.fromPath('files[]', microphone,
          filename: "AUDIO${current.toUtc()}.aac"));
    }

    return request.send().then((response) async {
      if (response.statusCode == 200) {
        return response.stream.bytesToString();
      }
      throw Exception('Fail to send message');
    }).then((json) {
      return OrderResponse.fromJson(json);
    });
  }

  static Future<OrderResponse> setStatus(
      {required Order order, String status = OrderStatus.waiting}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.put(
        Uri.https(uri, '/api/v1/orders/${order.orderId}'),
        headers: headers,
        body: jsonEncode({"order_status": status}));
    if (response.statusCode == 200) {
      return OrderResponse.fromJson(response.body);
    } else {
      return OrderResponse.fromJson(response.body);
    }
  }

  static Future<OrderResponse> setAssociate({required Order order}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.put(
      Uri.https(uri, '/api/v1/orders/${order.orderId}/associate'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return OrderResponse.fromJson(response.body);
    } else {
      throw Exception('Fail to get order');
    }
  }

  static Future<ApiResponse> getUnlistedOrders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(Uri.https(uri, '/api/orders/unlisted'),
        headers: headers);
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<ApiResponse> orderAccepted(int orderId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.post(
        Uri.https(uri, '/api/orders/$orderId/accepted'),
        headers: headers);
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<DetailStatisticsResponse> getDetailedStatistics() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
      Uri.https(uri, "/api/v1/orders/statistics/date"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return DetailStatisticsResponse.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<OverviewStatisticsResponse> getOverviewStatistics() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
      Uri.https(uri, "/api/v1/orders/statistics/status"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return OverviewStatisticsResponse.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to load users');
    }
  }
}
