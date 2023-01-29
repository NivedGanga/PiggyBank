import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:piggybank/core/colors/colors.dart';


ValueNotifier<Map<String, String>?> categoryTotalNotifier = ValueNotifier(null);

class homeListWidget extends StatelessWidget {
  final int index;
  final String amount;
  final String paisa;
  final String category;
  final String iconHExValue;
  homeListWidget(
      {super.key,
      required this.index,
      required this.amount,
      required this.paisa,
      required this.category,
      required this.iconHExValue});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Card(
            elevation: 10,
            shadowColor: Color.fromARGB(148, 0, 0, 0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: SizedBox(
              height: size.width * 0.25,
              child: Center(
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      IconData(int.parse(iconHExValue),
                          fontFamily: 'MaterialIcons'),
                      size: 40,
                      color: iconColorArray[index],
                    ),
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.currency_rupee,
                        size: 29,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 69,
                        child: AutoSizeText(
                          categoryTotalNotifier.value![category].toString(),
                          style: TextStyle(
                            fontSize: 28,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ),

                      // Text(
                      //   '.' + paisa,
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     color: primaryColor,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // )
                    ],
                  ),
                  trailing: SizedBox(
                    width: size.width * 0.25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: size.width * 0.045,
                          backgroundColor: secondaryColor,
                          child: Icon(
                            Icons.upload,
                            color: kWhite,
                            size: size.width * 0.045,
                          ),
                        ),
                        CircleAvatar(
                          radius: size.width * 0.045,
                          backgroundColor: secondaryColor,
                          child: Icon(
                            Icons.folder,
                            color: kWhite,
                            size: size.width * 0.045,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: Container(
            height: 25,
            width: 130,
            decoration: BoxDecoration(
              color: titleColorArray[index],
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                category.toUpperCase(),
                style: TextStyle(
                  color: kWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
