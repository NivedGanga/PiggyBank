import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:piggybank/core/constants/constants.dart';
import 'package:piggybank/core/constants/shared_preference_keys.dart';
import 'package:piggybank/presentation/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

signupService(
    {required String email,
    required String password,
    required String username,
    required BuildContext context}) {
  FirebaseAuth.instance
      .createUserWithEmailAndPassword(
    email: email,
    password: password,
  )
      .then((value) async {
    uid = value.user?.uid;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (route) => false);
    final sharedpref = await SharedPreferences.getInstance();
    sharedpref.setString(signinCheckKey, uid!);
    FirebaseFirestore.instance.collection('Userdata').doc(uid).set({
      'uid': uid,
      'username': username,
      'total': '0',
    });
  }).onError((error, stackTrace) {
    log(error.toString());
  });
}
