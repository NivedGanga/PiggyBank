import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggybank/core/colors/colors.dart';
import 'package:piggybank/core/constants/constants.dart';
import 'package:piggybank/domain/database/category_db/category_db.dart';
import 'package:piggybank/presentation/home/widgets/home_list.dart';
import 'package:piggybank/presentation/mainmenu_page/addcategory_page/add_category_screen.dart';
import 'package:piggybank/presentation/widgets/customscroll.dart';

class MainmenuPage extends StatelessWidget {
  MainmenuPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 247),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: size.width,
                height: 220,
                color: Color.fromARGB(255, 202, 220, 249),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                    Text(
                      'hello!!! Welcome back',
                      style: TextStyle(fontSize: 22, color: primaryColor),
                    ),
                    Text(
                      username + '!',
                      style: TextStyle(
                          fontSize: 30,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.6,
                          height: 56,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              totalMoneySpend,
                              style: TextStyle(
                                fontSize: 25,
                                color: kWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: primaryColor,
                            child: Icon(
                              Icons.calendar_today_rounded,
                              color: kWhite,
                            ),
                          ),
                          onTap: () {
                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate:
                                    DateTime.now().subtract(Duration(days: 30)),
                                lastDate: DateTime.now());
                          },
                        ),
                        SizedBox()
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 234, 234, 235),
                borderRadius: BorderRadius.circular(22),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.search),
                  hintText: 'search your spending',
                  focusColor: Colors.grey,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: CategoryDb.instance.categoryNotifier,
              builder: (context, value, child) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: ScrollConfiguration(
                      behavior: CustomScroll(),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return homeListWidget(
                              index: index,
                              amount: '12',
                              paisa: '25',
                              category: CategoryDb
                                  .instance.categoryNotifier.value[index].name,
                              iconHExValue: CategoryDb.instance.categoryNotifier
                                  .value[index].iconHex,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 25,
                            );
                          },
                          itemCount: CategoryDb
                              .instance.categoryNotifier.value.length),
                    ),
                  ),
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 138, 183, 255),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddCategoryScreen(),
          ));
        },
      ),
    );
  }
}
