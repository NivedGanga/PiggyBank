import 'package:flutter/material.dart';
import 'package:piggybank/core/colors/colors.dart';
import 'package:piggybank/presentation/login_page/login/loginpage.dart';
import 'package:piggybank/presentation/login_page/signup/signuppage.dart';
import 'package:piggybank/presentation/login_page/widgets/loginbutton.dart';

class WelcomeLoginPage extends StatelessWidget {
  const WelcomeLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(),
          const Text(
            'Welcome',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Here we are to Manage your finances',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Image(
                image: AssetImage('lib/assets/images/loginpage/loginpic.png')),
          ),
          const SizedBox(),
          LoginButton(
            name: 'Log In',
            widget: LoginPage(),
          ),
           LoginButton(
            name: "Sign Up",
            color: primaryColor,
            textColor: kWhite,
            widget: SignupPage(),
          ),
          const SizedBox(),
        ],
      )),
    );
  }
}
