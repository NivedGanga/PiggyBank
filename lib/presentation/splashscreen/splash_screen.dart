import 'package:flutter/material.dart';
import 'package:piggybank/core/colors/colors.dart';
import 'package:piggybank/domain/splashscreen/splash_function.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashTimeCheck(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PIGGYBANK',
              style: TextStyle(
                  color: kWhite, fontSize: 40, fontWeight: FontWeight.w200),
            ),
            Image(
                image: AssetImage(
                    'lib/assets/images/splashscreen/piggy_shadow.png'))
          ],
        ),
      ),
    );
  }
}
