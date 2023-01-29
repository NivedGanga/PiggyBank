import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:piggybank/core/constants/shared_preference_keys.dart';
import 'package:piggybank/presentation/home/widgets/bottom_navigation_bar.dart';
import 'package:piggybank/presentation/login_page/welcome_login.dart';

import 'package:shared_preferences/shared_preferences.dart';

logoutService(BuildContext context) {
  FirebaseAuth.instance.signOut().then((value) async {
    final sharedepref = await SharedPreferences.getInstance();
    await sharedepref.remove(signinCheckKey);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const WelcomeLoginPage(),
        ),
        (route) => false);
    selectedpage.value = 0;
  }).onError((error, stackTrace) {
    log(error.toString());
  });
}
