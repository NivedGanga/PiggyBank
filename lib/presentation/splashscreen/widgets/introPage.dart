import 'package:flutter/material.dart';
import 'package:piggybank/domain/intro_leafs/after_intro.dart';
import 'package:piggybank/presentation/splashscreen/intro_screen.dart';

class IntroPage extends StatelessWidget {
  IntroPage({
    Key? key,
    required this.imageURL,
    required this.title,
    required this.subTitle,
    this.isLastPage = false,
  }) : super(key: key);
  final String imageURL;
  final String title;
  final String subTitle;
  bool isLastPage;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 60, 102, 180),
          ),
          Transform.translate(
            offset: Offset(0, -size.height * 0.1),
            child: Container(
              height: size.height * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Image(image: AssetImage(imageURL)),
                  ),
                  Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        subTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Transform.translate(
                    offset: Offset(0, size.height * 0.05),
                    child: ClipOval(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: size.width * 0.15,
                        child: SizedBox(
                          height: 100,
                          width: 80,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 254, 41, 37)),
                                elevation: MaterialStateProperty.all(20),
                                shape: MaterialStateProperty.all(
                                    const CircleBorder())),
                            onPressed: () {
                              isLastPage
                                  ? afterIntro(context)
                                  : pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.decelerate);
                            },
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
