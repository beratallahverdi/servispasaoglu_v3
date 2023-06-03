import 'dart:convert';

import 'package:servispasaoglu_v3/classes/tuning_device.dart';
import 'package:servispasaoglu_v3/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TuningDevicesAPI {
  static Future<List<TuningDevice>> getTuningDevices() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {"Authorization": "${pref.getString("Authorization")}"};
    var uri = ServisPasaogluConstants.baseUrl;
    var response = await http.get(Uri.https(uri, '/api/v1/tuning-devices'),
        headers: headers);
    if (response.statusCode == 200) {
      return (json.decode(response.body)['data'] as List)
          .map((e) => TuningDevice.fromMap(e))
          .toList();
    } else {
      throw Exception('Failed to load tuning devices');
    }
  }
}
