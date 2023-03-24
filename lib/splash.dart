import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/animation.dart';
import 'login.dart';
class Splash_Animated extends StatelessWidget {
  const Splash_Animated({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 200,
        backgroundColor: Colors.white,
        pageTransitionType: PageTransitionType.topToBottom,
        splashTransition: SplashTransition.rotationTransition,
        splash:  CircleAvatar(radius: 100,
         child:Container( 
         color: Colors.white,
          child: Image.asset("assets/images/greenChat.jpg"),)
         // backgroundImage: AssetImage("assets/images/greenChat.jpg"),
        ),
        nextScreen:  LoginPage(),


        duration: 100,

        animationDuration: const Duration(seconds: 2));

  }
}