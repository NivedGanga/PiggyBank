import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:piggybank/presentation/account_page/account_page.dart';
import 'package:piggybank/presentation/home/widgets/bottom_navigation_bar.dart';
import 'package:piggybank/presentation/mainmenu_page/mainmenu_page.dart';
import 'package:piggybank/presentation/transactions_page/transactions_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final pages = [
    MainmenuPage(),
    TransactionsPage(),
    AccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 247),
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder(
        valueListenable: selectedpage,
        builder: (context, value, child) {
          return pages[value];
        },
      ),
      bottomNavigationBar: BottomNavBar(),
      
    );
  }
}
