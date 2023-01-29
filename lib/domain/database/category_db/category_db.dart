import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:piggybank/core/constants/constants.dart';
import 'package:piggybank/model/category_model.dart';
import 'package:piggybank/presentation/home/widgets/home_list.dart';


abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  // Future<void> deleteCtegory(String id);
}

class CategoryDb extends CategoryDbFunctions {
  CategoryDb._internal();
  static CategoryDb instance = CategoryDb._internal();
  factory CategoryDb() {
    return instance;
  }
  ValueNotifier<List<CategoryModel>> categoryNotifier = ValueNotifier([]);
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final user =
        await FirebaseFirestore.instance.collection(uid!).doc('Categories');
    Map<String, String> categoryMap = {
      'id': value.id,
      'name': value.name,
      'iconHex': value.iconHex
    };
    final tempUser =
        await FirebaseFirestore.instance.collection('Userdata').doc(uid).get();
    final tempUserData = tempUser.data();
    tempUserData![value.name] = "0";
    FirebaseFirestore.instance.collection('Userdata').doc(uid).set(tempUserData);
    if (categoryTotalNotifier.value == null) {
      categoryTotalNotifier.value = {value.name: "0"};
    } else {
      categoryTotalNotifier.value![value.name] = "0";
    }
    categoryTotalNotifier.notifyListeners();
    user
        .collection('categories')
        .doc(DateTime.now().microsecondsSinceEpoch.toString())
        .set(categoryMap);
    categoryNotifier.value.add(value);
    categoryNotifier.notifyListeners();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final user = await FirebaseFirestore.instance
        .collection(uid!)
        .doc('Categories')
        .collection('categories')
        .orderBy('id', descending: false)
        .get();
    final categories = user.docs.map((e) => e.data()).toList();
    List<CategoryModel> categoryList = categories
        .map((map) => CategoryModel(
            id: map['id'], name: map['name'], iconHex: map['iconHex']))
        .toList();

    return categoryList;
  }
}
