import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggybank/core/constants/constants.dart';
import 'package:piggybank/model/transaction_model.dart';
import 'package:piggybank/presentation/home/home.dart';
import 'package:piggybank/presentation/home/widgets/home_list.dart';

abstract class TransactionDBFunctions {
  Future<void> insertTransaction(TransactionModel value, context);
  Future<List<TransactionModel>> getalltransactions();
  // Future<void> refreshTransactionUI();
  // Future<void> deteleTransaction(String e);
}

class TransactionDb extends TransactionDBFunctions {
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();
  factory TransactionDb() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionsnotifier =
      ValueNotifier([]);

  @override
  Future<void> insertTransaction(value, context) async {
    final tempTotal = await totalmoneyspend();
    final tempCategoryCurrent =
        await categorymoneyspend(category: value.category);
    totalMoneySpend = '${double.parse(tempTotal) + double.parse(value.amount)}';
    final totalCategoryNew =
        '${double.parse(tempCategoryCurrent) + double.parse(value.amount)}';
    transactionsnotifier.value.add(value);
    FirebaseFirestore.instance.collection('Userdata').doc(uid).update({
      "total": totalMoneySpend,
      value.category: totalCategoryNew.toString()
    });
    categoryTotalNotifier.value![value.category] = totalCategoryNew;
    categoryTotalNotifier.notifyListeners();
    FirebaseFirestore.instance
        .collection(uid!)
        .doc('Transactions')
        .collection('transactions')
        .doc(value.id)
        .set({
      'id': value.id,
      'amount': value.amount,
      'purpose': value.purpose,
      'datetime': value.date,
      'category': value.category
    }).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (route) => false);
    });
  }

  @override
  getalltransactions() async {
    final _transactions = await FirebaseFirestore.instance
        .collection(uid!)
        .doc('Transactions')
        .collection('transactions')
        .get();
    final transactions = _transactions.docs.map((e) => e.data()).toList();
    List<TransactionModel> transactionList = transactions
        .map((map) => TransactionModel(
            id: map['id'],
            amount: map['amount'],
            date: map['datetime'],
            category: map['category'],
            purpose: map['purpose']))
        .toList();
    return transactionList;
  }
}

Future<String> totalmoneyspend() async {
  final total =
      await FirebaseFirestore.instance.collection('Userdata').doc(uid).get();
  return total.data()!['total'];
}

Future<String> categorymoneyspend({required String category}) async {
  final total =
      await FirebaseFirestore.instance.collection('Userdata').doc(uid).get();
  return total.data()![category];
}
