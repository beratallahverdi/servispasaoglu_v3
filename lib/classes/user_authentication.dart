import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:servispasaoglu_v3/classes/logged_user.dart';
import 'package:servispasaoglu_v3/utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthentication extends State<StatefulWidget> {
  ServisPasaogluUser? user;
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey("user")) {
        setUser();
      }
    });
    super.initState();
  }

  void setUser() async {
    var finalUser = await ServisPasaogluFunctions.getUser();
    setState(() {
      user = finalUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
