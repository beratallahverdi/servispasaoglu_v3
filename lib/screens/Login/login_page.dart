import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:servispasaoglu_v3/api/login.dart';
import 'package:servispasaoglu_v3/api/response.dart';
import 'package:servispasaoglu_v3/screens/routes.dart';
import 'package:servispasaoglu_v3/generated/l10n.dart';
import 'package:servispasaoglu_v3/utils/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  late TextEditingController username;
  late TextEditingController password;

  static const String routeName = '/pages/login';

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    username = TextEditingController();
    password = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).loginPageTitle,
            style: Theme.of(context).appBarTheme.titleTextStyle),
        leading: GestureDetector(
          onTap: () {
            Navigator.canPop(context)
                ? Navigator.pop(context)
                : Navigator.of(context).pushReplacementNamed(Routes.home);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 26.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Center(
                child: Container(
                    padding: const EdgeInsets.all(20.0),
                    width: 250,
                    height: 250,
                    /*decoration: BoxDecoration(
										    color: Colors.red,
										    borderRadius: BorderRadius.circular(50.0)),*/
                    child:
                        Image.asset(ServisPasaogluData.info["companyLogo"]!)),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: S.of(context).username,
                    hintText: S.of(context).usernameHint),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: S.of(context).password,
                    hintText: S.of(context).passwordHint),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface,
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  SharedPreferences preferences = await prefs;

                  String loginUsername = username.value.text.trim();
                  if (password.value.text.isNotEmpty &&
                      username.value.text.isNotEmpty) {
                    String loginPassword = md5
                        .convert(utf8.encode(password.value.text))
                        .toString();
                    String basic = base64Encode(
                        utf8.encode("$loginUsername:$loginPassword"));
                    ApiResponse res = await LoginAPI.get('Basic $basic');
                    preferences.setString("Authorization", 'Basic $basic');
                    preferences.setString("user", res.data[0]).then(
                        (bool success) => Navigator.of(context)
                            .pushReplacementNamed(Routes.orders));
                  }
                },
                child: Text(
                  S.of(context).loginPageTitle,
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
