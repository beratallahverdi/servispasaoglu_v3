import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:servispasaoglu_v3/classes/logged_user.dart';
import 'package:servispasaoglu_v3/utils/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServisPasaogluFunctions {
  static leadingBackButton(context) => Navigator.canPop(context)
      ? GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 26.0,
          ),
        )
      : Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SizedBox(
              height: 100.0,
              width: 100.0, // fixed width and height
              child: Image.asset("${ServisPasaogluData.info["companyLogo"]}")));

  static Future<File> responseSave(http.Response response) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    Map<String, String> qParams = response.request!.url.queryParameters;
    String pathName = "$dir/${qParams["orderId"]}/${qParams["fileName"]}";
    File file = File(pathName);
    if (file.existsSync()) {
      return file;
    } else {
      File(pathName).createSync(recursive: true);
      file = File(pathName);
      await file.writeAsBytes(response.bodyBytes);
      return file;
    }
  }

  static Future<bool> checkUser() {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.containsKey('user'));
  }

  static Future<ServisPasaogluUser?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('user')
        ? ServisPasaogluUser.fromJson(json.decode(prefs.getString("user")!))
        : null;
  }
}
