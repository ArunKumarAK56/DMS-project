import 'dart:async';
import 'package:dms_dealers/utils/color_resources.dart';
import 'package:flutter/material.dart';

import '../../router.dart';
import '../../utils/image_resources.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.all(20),
        child: Center(
          child: Image.asset(
            ImageResource.splashLogo,
            // fit: BoxFit.contain,
            width: 200,
            height: 200,
            // color: Colors.white,
          )
        ),
      )
    );
  }
}
