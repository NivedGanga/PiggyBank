import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:piggybank/core/colors/colors.dart';
import 'package:piggybank/domain/database/transaction_db/transaction_db.dart';
import 'package:piggybank/presentation/transactions_page/widgets/add_transaction.dart';
import 'package:piggybank/presentation/transactions_page/widgets/transaction_tile.dart';
import 'package:piggybank/presentation/widgets/customscroll.dart';


class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: CustomScroll(),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                elevation: 0,
                toolbarHeight: 70,
                backgroundColor: Color.fromARGB(255, 224, 236, 255),
                floating: true,
                snap: true,
                title: Text(
                  'All Transactions',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                centerTitle: true,
              ),
            ],
            body: ListView(
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 224, 236, 255),
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                ),
                ValueListenableBuilder(
                    valueListenable:
                        TransactionDb.instance.transactionsnotifier,
                    builder: (context, value, child) {
                      return ListView.separated(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TransactionTile(
                                obj: value[index],
                                index: index,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 2,
                            );
                          },
                          itemCount: TransactionDb
                              .instance.transactionsnotifier.value.length);
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 138, 183, 255),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddTransaction(),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
