import 'package:flutter/material.dart';

import 'package:piggybank/core/colors/colors.dart';
import 'package:piggybank/domain/database/category_db/category_db.dart';
import 'package:piggybank/domain/database/transaction_db/transaction_db.dart';
import 'package:piggybank/model/category_model.dart';
import 'package:piggybank/model/transaction_model.dart';

class AddTransaction extends StatelessWidget {
  AddTransaction({super.key});
  ValueNotifier<String?> dropdownitemnotifier = ValueNotifier(null);
  late final amountController = TextEditingController();
  late final purposeController = TextEditingController();
  late DateTime? selectedDate;
  late CategoryModel selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              'Add Transaction',
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: amountController,
              decoration: InputDecoration(
                  hintText: 'Amount',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            TextFormField(
              controller: purposeController,
              decoration: InputDecoration(
                  hintText: 'Purpose(Optional)',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ValueListenableBuilder(
                  valueListenable: dropdownitemnotifier,
                  builder: (context, newvalue, child) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: DropdownButton(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(20),
                        value: newvalue,
                        hint: Text('Select Categories'),
                        items:
                            CategoryDb.instance.categoryNotifier.value.map((e) {
                          return DropdownMenuItem(
                            child: Text(e.name),
                            value: e.id,
                            onTap: () {
                              selectedCategory = e;
                            },
                          );
                        }).toList(),
                        onChanged: (valuee) {
                          if (valuee == null) {
                            return;
                          }
                          dropdownitemnotifier.value = valuee.toString();
                          dropdownitemnotifier.notifyListeners();
                        },
                      ),
                    );
                  },
                ),
                IconButton(
                    onPressed: () async {
                      selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days: 30)),
                        lastDate: DateTime.now(),
                      );
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      size: 30,
                      color: primaryColor,
                    )),
              ],
            ),
            SizedBox(
              width: 200,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  if (amountController.text == '') {
                    return;
                  }
                  if (selectedDate == null) {
                    return;
                  }
                  if (dropdownitemnotifier.value == null) {
                    return;
                  }
                  final temp = TransactionModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    purpose: purposeController.text,
                    amount: amountController.text,
                    date:
                        '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    category: selectedCategory.name,
                  );
                  TransactionDb.instance.insertTransaction(temp, context);
                },
                child: Text('Submit'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)))),
              ),
            ),
            SizedBox(
              height: 240,
            )
          ],
        ),
      )),
    );
  }
}
