import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggybank/core/constants/shared_preference_keys.dart';
import 'package:piggybank/presentation/login_page/welcome_login.dart';

import 'package:shared_preferences/shared_preferences.dart';

afterIntro(context) async {
  final sharedpref = await SharedPreferences.getInstance();
  sharedpref.setBool(isOpenKey, true);
  Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => WelcomeLoginPage(),
                        ));
}
