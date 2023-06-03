import 'package:servispasaoglu_v3/utils/constants.dart';
import 'package:http/http.dart' as http;

class TuningAPI {
  static Future<String?> fetchChipTuningData() async {
    var response = await http.post(
      Uri.https(ServisPasaogluConstants.baseUrl, '/api/chip-tuning-calculator'),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Fail to load orders');
    }
  }
}
