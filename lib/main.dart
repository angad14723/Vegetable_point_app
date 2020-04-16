import 'package:flutter/material.dart';
import 'package:vegetable_point/screens/CategoryScreen.dart';
import 'package:vegetable_point/screens/SplashScreen.dart';
import 'package:vegetable_point/screens/MainScreen.dart';

/*var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/intro": (BuildContext context) => IntroScreen(),
};*/

void main() => runApp(MaterialApp(
      theme:
          ThemeData(primaryColor: Colors.red, accentColor: Colors.yellowAccent),
      debugShowCheckedModeBanner: false,
      home: HomeClass(),
      //routes: routes
    ));
