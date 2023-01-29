
import 'package:flutter/material.dart';
import 'package:piggybank/core/colors/colors.dart';

class LoginButton extends StatelessWidget {
  final Widget? widget;
  final String name;
  final Color color;
  final Color textColor;
  final void Function()? onclick;
  const LoginButton({
    Key? key,
    required this.name,
    this.color = kWhite,
    this.textColor = Colors.black,
    this.widget,
    this.onclick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        width: size.width,
        height: 60,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(2),
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(
                    color: color == kWhite ? Colors.black : primaryColor,
                    width: 1))),
          ),
          onPressed: onclick != null
              ? onclick
              : () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return widget!;
                    },
                  ));
                },
          child: Text(
            name,
            style: TextStyle(color: textColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
