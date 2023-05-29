import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soham_academy/screens/authentication.dart';
import 'package:soham_academy/screens/login.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedSplashScreen(
        duration: 3000,
        splash: Img(),
        nextScreen: Login(),
        splashIconSize:200.0,
        backgroundColor: Colors.white,
        centered: true,
        splashTransition:SplashTransition.rotationTransition,
        pageTransitionType: PageTransitionType.leftToRight,
    );
  }

}


class Img extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage=AssetImage("images/soham_logo.png");
    Image image=Image(image: assetImage,height: 200,width: 200,);
    return Container(child: image);
  }

}