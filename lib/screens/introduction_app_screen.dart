import 'package:flutter/material.dart';
import 'package:placement/screens/auth_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class IntroAppPagesScreen extends StatelessWidget {
  const IntroAppPagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntroductionScreen(
              globalBackgroundColor: Colors.white54,
              pages: [
                PageViewModel(
                  title: "Welcome to College Placement System",
                  body: "Your Gateway to Exciting Career Opportunities",
                  image: Lottie.asset('assets/lottie/1screen.json'),
                  decoration: PageDecoration(
                    pageColor: Colors.white,
                    bodyAlignment: Alignment.center,
                    bodyPadding: const EdgeInsets.all(8),
                    bodyTextStyle:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade600,
                            ),
                    imageAlignment: Alignment.bottomCenter,
                    bodyFlex: 2,
                    imageFlex: 3,
                    titleTextStyle: Theme.of(context).textTheme.titleLarge!,
                  ),
                ),
                PageViewModel(
                  title: "Explore Job Opportunities",
                  body: "Find the Perfect Job Match for Your Skills.",
                  image: Lottie.asset('assets/lottie/2screen.json'),
                  decoration: PageDecoration(
                    pageColor: Colors.white,
                    bodyAlignment: Alignment.center,
                    bodyPadding: const EdgeInsets.all(8),
                    bodyTextStyle:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade600,
                            ),
                    imageAlignment: Alignment.bottomCenter,
                    bodyFlex: 2,
                    imageFlex: 3,
                    titleTextStyle: Theme.of(context).textTheme.titleLarge!,
                  ),
                ),
                PageViewModel(
                  title: "Upload Your Resume",
                  body: "Showcase Your Talents to Top Students.",
                  image: Lottie.asset('assets/lottie/3screen.json'),
                  decoration: PageDecoration(
                    pageColor: Colors.white,
                    bodyAlignment: Alignment.center,
                    bodyPadding: const EdgeInsets.all(8),
                    bodyTextStyle:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade600,
                            ),
                    imageAlignment: Alignment.bottomCenter,
                    bodyFlex: 2,
                    imageFlex: 3,
                    titleTextStyle: Theme.of(context).textTheme.titleLarge!,
                  ),
                ),
                PageViewModel(
                  title: " Get Ready for Success",
                  body: "Prepare for Interviews and Ace Your Career.",
                  image: Lottie.asset('assets/lottie/4screen.json'),
                  decoration: PageDecoration(
                    pageColor: Colors.white,
                    bodyAlignment: Alignment.center,
                    bodyPadding: const EdgeInsets.all(8),
                    bodyTextStyle:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade600,
                            ),
                    imageAlignment: Alignment.bottomCenter,
                    bodyFlex: 2,
                    imageFlex: 3,
                    titleTextStyle: Theme.of(context).textTheme.titleLarge!,
                  ),
                ),
              ],
              onDone: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthScreen(),
                  ),
                );
              }, //go to home page on done
              onSkip: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthScreen(),
                  ),
                );
              },
              showSkipButton: true,
              showNextButton: true,
              showDoneButton: true,

              nextFlex: 1,

              skip: const Text(
                'SKIP',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),

              next: const Text(
                'NEXT',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              done: const Text(
                'DONE',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),

              dotsDecorator: const DotsDecorator(
                spacing: EdgeInsets.all(5),
                size: Size(10.0, 10.0), //size of dots
                color: Colors.grey, //color of dots
                activeSize: Size(25.0, 10.0),
                activeColor: Colors.black, //color of active dot
                activeShape: RoundedRectangleBorder(
                  //shave of active dot
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
