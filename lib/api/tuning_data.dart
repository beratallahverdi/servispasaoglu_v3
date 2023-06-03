import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:servispasaoglu_v3/utils/constants.dart';

class TuningDataAPI {
  static Future<Map<String, dynamic>> get() async {
    var uri = ServisPasaogluConstants.baseUrl;
    const String apiLink = '/api/chip-tuning-calculator';
    var response = await http.post(Uri.https(uri, apiLink));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load album');
    }
    /*
    var uri = "www.servispasaoglu.com.tr";
    final String apiLink = '/wp-admin/admin-ajax.php';
    var response = await http
        .post(Uri.https(uri, apiLink), body: {"action": "get_values"});
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load album');
    }
    */
  }
}
