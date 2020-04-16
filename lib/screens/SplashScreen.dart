import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vegetable_point/screens/MainScreen.dart';
import 'package:vegetable_point/styles/AppColors.dart';

import 'CategoryScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
     Timer(Duration(seconds: 5), () => Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => HomeClass()),
     ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/carrot.svg',
                height: 150.0,
                width: 150.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Vegetable",
                    style: TextStyle(
                        color: AppColors.PRIMARY_COLOR,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Raleway"),
                  ),
                  Text(
                    "Point",
                    style: TextStyle(
                        color: AppColors.ACCENT_COLOR,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Raleway"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
