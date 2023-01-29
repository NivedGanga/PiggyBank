import 'package:flutter/material.dart';
import 'package:piggybank/core/colors/colors.dart';
import 'package:piggybank/model/transaction_model.dart';


class TransactionTile extends StatelessWidget {
  final int index;
  final TransactionModel obj;
  const TransactionTile({super.key, required this.index, required this.obj});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      shadowColor:
          Colors.accents[index % Colors.accents.length].withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: SizedBox(
          width: size.width * 0.9,
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Card(
                color: Colors.accents[index % Colors.accents.length]
                    .withOpacity(0.6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    obj.category,
                    style: TextStyle(
                        color: kWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(),
              Row(
                children: [
                  Icon(
                    Icons.currency_rupee,
                    color: primaryColor,
                  ),
                  Text(
                    obj.amount,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(),
              Text(
                obj.date,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(),
            ],
          )),
    );
  }
}
