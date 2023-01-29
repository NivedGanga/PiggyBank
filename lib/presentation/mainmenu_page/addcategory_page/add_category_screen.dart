import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:piggybank/core/colors/colors.dart';
import 'package:piggybank/core/constants/constants.dart';
import 'package:piggybank/domain/database/category_db/category_db.dart';
import 'package:piggybank/model/category_model.dart';
import 'package:piggybank/presentation/home/home.dart';

class AddCategoryScreen extends StatelessWidget {
  ValueNotifier iconNotifier = ValueNotifier(null);
  int selectedIndex = 0;
  AddCategoryScreen({super.key});
  final categoryNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            'Add Category',
            style: TextStyle(
              fontSize: 30,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: categoryNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            child: ValueListenableBuilder(
                valueListenable: iconNotifier,
                builder: (context, newValue, child) {
                  return DropdownButton(
                      hint: newValue == null
                          ? Text('Select Icon')
                          : Icon(
                              IconData(
                                  int.parse(
                                      categoryIconHexs[newValue.toString()]!),
                                  fontFamily: 'MaterialIcons'),
                              color: iconColorArray[
                                  newValue % iconColorArray.length],
                              size: 30,
                            ),
                      menuMaxHeight: 200,
                      items: List.generate(categoryIconHexs.length, (index) {
                        return DropdownMenuItem(
                          value: index.toString(),
                          child: Icon(
                            IconData(
                                int.parse(categoryIconHexs[index.toString()]!),
                                fontFamily: 'MaterialIcons'),
                            color:
                                iconColorArray[index % iconColorArray.length],
                            size: 30,
                          ),
                          onTap: (() {
                            selectedIndex = index;
                          }),
                        );
                      }),
                      onChanged: (e) {
                        if (e == null) {
                          return;
                        }
                        iconNotifier.value = selectedIndex;
                        iconNotifier.notifyListeners();
                      });
                }),
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (categoryNameController.text == '') {
                  return;
                }
                if (iconNotifier.value == null) {
                  return;
                }
                final category = CategoryModel(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  name: categoryNameController.text,
                  iconHex: categoryIconHexs[iconNotifier.value.toString()]!,
                );
                CategoryDb.instance.insertCategory(category).then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                      (route) => false);
                });
              },
              child: Text(
                'Add Category',
                style: TextStyle(
                  fontSize: 20,
                  color: kWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)))),
            ),
          )
        ],
      )),
    );
  }
}
