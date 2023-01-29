import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:piggybank/core/constants/constants.dart';
import 'package:piggybank/core/constants/shared_preference_keys.dart';
import 'package:piggybank/domain/database/category_db/category_db.dart';
import 'package:piggybank/domain/database/transaction_db/transaction_db.dart';
import 'package:piggybank/domain/splashscreen/splash_function.dart';
import 'package:piggybank/presentation/home/home.dart';

import 'package:shared_preferences/shared_preferences.dart';

loginService(
    {required String email,
    required String password,
    required BuildContext context}) {
  FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((value) async {
    final userid = value.user;
    uid = userid?.uid;
    log(uid ?? 'no uid');
    final userdatas =
        await FirebaseFirestore.instance.collection('Userdata').doc(uid).get();

    final sharedpref = await SharedPreferences.getInstance();
    await sharedpref.setString(signinCheckKey, uid!);
    CategoryDb.instance.categoryNotifier.value =
        await CategoryDb.instance.getCategories();
    TransactionDb.instance.transactionsnotifier.value =
        await TransactionDb.instance.getalltransactions();
    username = await userdatas.data()!['username'];
    getCategoryTotal(userdata: userdatas.data()!);

    totalMoneySpend = await userdatas.data()!['total'];
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (route) => false);
  }).onError((error, stackTrace) {
    log(error.toString());
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Invalid Credentials')));
  });
}
