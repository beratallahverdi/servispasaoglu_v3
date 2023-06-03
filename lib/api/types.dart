import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:servispasaoglu_v3/classes/ecu.dart';
import 'package:servispasaoglu_v3/classes/engine.dart';
import 'package:servispasaoglu_v3/classes/generation.dart';
import 'package:servispasaoglu_v3/classes/model.dart';
import 'package:servispasaoglu_v3/classes/brand.dart';
import 'package:servispasaoglu_v3/classes/order.dart';
import 'package:servispasaoglu_v3/classes/type_response.dart';
import 'package:servispasaoglu_v3/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TypesAPI {
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
      throw Exception('Fail to get order types');
    }
  }

  static Future<List<Model>> getModels({required Brand brand}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
      Uri.https(uri, '/api/v1/types', {'brand': '${brand.brandId}'}),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return (json.decode(response.body)['data'] as List)
          .map((data) => Model.fromMap(data))
          .toList();
    } else {
      throw Exception('Fail to get models');
    }
  }

  static Future<List<Generation>> getGenerations({required Model model}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
      Uri.https(uri, '/api/v1/types', {'model': '${model.modelId}'}),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return (json.decode(response.body)['data'] as List)
          .map((data) => Generation.fromMap(data))
          .toList();
    } else {
      throw Exception('Fail to get generations');
    }
  }

  static Future<List<Engine>> getEngines(
      {required Generation generation}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
      Uri.https(
          uri, '/api/v1/types', {'generation': '${generation.generationId}'}),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return (json.decode(response.body)['data'] as List)
          .map((data) => Engine.fromMap(data))
          .toList();
    } else {
      throw Exception('Fail to get engines');
    }
  }

  static Future<List<Ecu>> getEcus({required Engine engine}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(
      Uri.https(uri, '/api/v1/types', {'engine': '${engine.engineId}'}),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return (json.decode(response.body)['data'] as List)
          .map((data) => Ecu.fromMap(data))
          .toList();
    } else {
      throw Exception('Fail to get ecus');
    }
  }
}
