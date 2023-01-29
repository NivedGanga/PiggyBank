import 'package:flutter/material.dart';
import 'package:piggybank/core/colors/colors.dart';
import 'package:piggybank/domain/intro_leafs/after_intro.dart';
import 'package:piggybank/presentation/splashscreen/widgets/introPage.dart';


import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final pageController = PageController(viewportFraction: 1, keepPage: true);

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});

  final pages = [
    IntroPage(
        imageURL: 'lib/assets/images/splashscreen/splash_image.png',
        title: 'At Any Time',
        subTitle:
            'Your courses are available at any time you \n want. Join us now !'),
    IntroPage(
        imageURL: 'lib/assets/images/splashscreen/splash_image.png',
        title: '2e',
        subTitle:
            'Your coursbasifhybiufhft any time you \n want. Join us now !'),
    IntroPage(
      imageURL: 'lib/assets/images/splashscreen/splash_image.png',
      title: '3',
      subTitle: 'Your not available but at any time you \n want. Join us now !',
      isLastPage: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                padEnds: false,
                controller: pageController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Builder(builder: (context) {
                    return pages[index];
                  });
                },
                itemCount: pages.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        pageController.previousPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      },
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: kWhite,
                          fontSize: 18,
                        ),
                      )),
                  SmoothPageIndicator(
                      controller: pageController,
                      count: pages.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Color.fromARGB(164, 255, 255, 255),
                        activeDotColor: kWhite,
                        radius: 10,
                        expansionFactor: 2,
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        spacing: 6,
                      )),
                  TextButton(
                      onPressed: () {
                        afterIntro(context);
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(color: kWhite, fontSize: 18),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
