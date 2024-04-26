import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:buddify/views/screen/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/image/bg.jpeg'),
          fit: BoxFit.cover,
        )),
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Lottie.asset(
                'assets/image/ClvPDVynqX.json',
                height: size.height / 2.5,
                animate: true,
                fit: BoxFit.contain,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: AnimatedTextKit(
                  animatedTexts: [
                    FadeAnimatedText(
                      "Meet Buddify !",
                      textStyle: GoogleFonts.kodchasan(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize: 32,
                          fontWeight: FontWeight.w400),
                    ),
                    FadeAnimatedText(
                      'Your... ',
                      textStyle: GoogleFonts.kodchasan(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize: 32,
                          fontWeight: FontWeight.w400),
                    ),
                    FadeAnimatedText(
                      'Personal Buddy!!!',
                      textStyle: GoogleFonts.kodchasan(
                          color: Color(0xff57cfdf),
                          fontSize: 24,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                  totalRepeatCount: 1,
                  onFinished: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: HomePage(),
                            duration: Duration(milliseconds: 1000),
                            type: PageTransitionType.bottomToTop));
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
