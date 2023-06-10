import 'package:vartalap/screens/login_screen.dart';
import 'package:vartalap/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:vartalap/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login_screen.dart';
import 'package:vartalap/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'wlc';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,          // here vsync:this shows that _WelcomeScreentate object is going to provide
                            // ticker for the animation controller
      duration: Duration(seconds: 1),
    );
    //animation=CurvedAnimation(parent: controller, curve: Curves.decelerate); // while applying the curves animation the upperbound of controller shouldnt be greater than 1
    animation=ColorTween(begin: kSignUpInactive,end: kPrimaryColor).animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {

      });
    });
  }

@override
  void dispose(){
    controller.dispose();
    super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Image(
                      image: AssetImage('images/chat.png'),
                    ),
                  ),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
                  child: AnimatedTextKit(
                    totalRepeatCount: 1,
                    animatedTexts:[TyperAnimatedText('Vartalap')],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 100,
            ),
            CustomButtons(color: kLogin, text: 'Log In', onPressed: () {
              Navigator.pushNamed(context, LogIn.id);
            },),
            CustomButtons(color: kSignUp, text: 'Sign Up', onPressed: (){
              Navigator.pushNamed(context, SignUp.id);
            },),

          ],
        ),
      ),
    );
  }
}


