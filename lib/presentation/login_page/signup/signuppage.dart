import 'package:flutter/material.dart';
import 'package:piggybank/core/colors/colors.dart';
import 'package:piggybank/core/constants/constants.dart';
import 'package:piggybank/domain/signup/signup_service.dart';
import 'package:piggybank/presentation/login_page/login/loginpage.dart';
import 'package:piggybank/presentation/login_page/widgets/loginbutton.dart';


class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final repasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Text(
            'Sign up',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Create an account, it's free"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: usernamecontroller,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 5,
                ),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 5,
                ),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: passwordcontroller,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 5,
                ),
                const Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: repasswordcontroller,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          LoginButton(
            name: 'Sign up',
            color: primaryColor,
            textColor: kWhite,
            onclick: () {
              if (emailcontroller.text == '') {
                return;
              }
              if (passwordcontroller.text == '') {
                return;
              }
              if (usernamecontroller.text == '') {
                return;
              }
              if (passwordcontroller.text != repasswordcontroller.text) {
                return;
              }
              username = usernamecontroller.text;
              signupService(
                  email: emailcontroller.text,
                  password: passwordcontroller.text,
                  username: usernamecontroller.text,
                  context: context);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ))
            ],
          ),
          SizedBox()
        ],
      )),
    );
  }
}
