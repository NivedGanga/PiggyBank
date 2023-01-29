import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

ValueNotifier<int> selectedpage = ValueNotifier(0);

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedpage,
        builder: (context, value, child) {
          return BottomNavigationBar(
            currentIndex: value,
            items: const [
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.list),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.category),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.account_circle),
              ),
            ],
            onTap: (value) {
              selectedpage.value = value;
              selectedpage.notifyListeners();
            },
          );
        });
  }
}
