import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:piggybank/core/constants/constants.dart';
import 'package:piggybank/core/constants/shared_preference_keys.dart';
import 'package:piggybank/domain/database/category_db/category_db.dart';
import 'package:piggybank/domain/database/transaction_db/transaction_db.dart';
import 'package:piggybank/model/transaction_model.dart';
import 'package:piggybank/presentation/home/home.dart';
import 'package:piggybank/presentation/home/widgets/home_list.dart';
import 'package:piggybank/presentation/login_page/welcome_login.dart';
import 'package:piggybank/presentation/splashscreen/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> splashTimeCheck(context) async {
  await Future.delayed(const Duration(seconds: 2));
  final sharedpref = await SharedPreferences.getInstance();
  final checker = sharedpref.getBool(isOpenKey) ?? false;
  final Widget page;
  if (checker) {
    final sharedprefs = await SharedPreferences.getInstance();
    final loginChecker = sharedprefs.getString(signinCheckKey) ?? '';
    if (loginChecker != '') {
      uid = loginChecker;
      CategoryDb.instance.categoryNotifier.value =
          await CategoryDb.instance.getCategories();
      TransactionDb.instance.transactionsnotifier.value =
          await TransactionDb.instance.getalltransactions();
      final userdatas = await FirebaseFirestore.instance
          .collection('Userdata')
          .doc(uid)
          .get();
      getCategoryTotal(userdata: userdatas.data()!);
      username = await userdatas.data()!['username'];
      totalMoneySpend = await userdatas.data()!['total'];
      page = HomePage();
    } else {
      page = const WelcomeLoginPage();
    }
  } else {
    page = IntroScreen();
  }
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (route) => false);
}

sortTransaction() {
  List<List<TransactionModel>> categorizedTransactionList;
  for (var i = 0; i < CategoryDb.instance.categoryNotifier.value.length; i++) {
    TransactionDb.instance.transactionsnotifier.value.sort();
  }
}

getCategoryTotal({required Map<String, dynamic> userdata}) {
  final allCategories = CategoryDb.instance.categoryNotifier.value;
  for (var i = 0; i < allCategories.length; i++) {
    if (categoryTotalNotifier.value == null) {
      categoryTotalNotifier.value = {
        allCategories[i].name: userdata[allCategories[i].name]
      };
    } else {}
    categoryTotalNotifier.value![allCategories[i].name] =
        userdata[allCategories[i].name];
  }
}
