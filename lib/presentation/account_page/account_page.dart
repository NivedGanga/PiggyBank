import 'package:flutter/material.dart';
import 'package:piggybank/domain/logout/logout_service.dart';


class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            logoutService(context);
          },
          child: Text('sign out'),
        ),
      ),
    );
  }
}
