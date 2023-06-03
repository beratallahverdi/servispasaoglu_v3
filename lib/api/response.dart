import 'package:servispasaoglu_v3/classes/logged_user.dart';

class ApiResponse {
  final String status;
  final Map<dynamic, dynamic> data;
  final String message;
  final String? type;

  ApiResponse(
      {required this.status,
      required this.data,
      required this.message,
      this.type});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    if (json["type"] == "login") {
      json['data'] = (<String>[
        ServisPasaogluUser.fromJson(json['data']).toString()
      ]).asMap();
    }
    return ApiResponse(
      status: json['status'],
      data: json['data'],
      message: json['message'],
      type: json['type'],
    );
  }
}
