import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_point/styles/AppColors.dart';

class FAQclass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateFAQ();
  }
}

class StateFAQ extends State<FAQclass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        title: Text(
          "Frequently asked questions",
          style: TextStyle(fontFamily: "Raleway"),
        ),
      ),
      body: _createFAQbody(),
    );
  }

  _createFAQbody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 4.0,
              color: Colors.white,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, right: 5.0, left: 5.0),
                child: ListTile(
                  title: Text(
                    "What are our service areas?",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16.0,
                        color: Colors.black,fontWeight: FontWeight.w500),
                  ),
                  subtitle:Text(
                    "Currently we are serving in delhi ncr only.",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 12.0,
                        color: Colors.black),
                  ) ,
                ),
              ),
            ),Card(
              elevation: 4.0,
              color: Colors.white,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, right: 5.0, left: 5.0),
                child: ListTile(
                  title: Text(
                    "What is the minimum order value?",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16.0,
                        color: Colors.black,fontWeight: FontWeight.w500),
                  ),
                  subtitle:Text(
                    "There must be minimum order value of INR 200.",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 12.0,
                        color: Colors.black),
                  ) ,
                ),
              ),
            ),Card(
              elevation: 4.0,
              color: Colors.white,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10.0, bottom:10.0, right: 5.0, left: 5.0),
                child: ListTile(
                  title: Text(
                    "What are the delivery days?",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16.0,
                        color: Colors.black,fontWeight: FontWeight.w500),
                  ),
                  subtitle:Text(
                    "No delivery on saturday - Order placed on saturay will be delivered on monday.",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 12.0,
                        color: Colors.black),
                  ) ,
                ),
              ),
            ),Card(
              elevation: 4.0,
              color: Colors.white,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, right: 5.0, left: 5.0),
                child: ListTile(
                  title: Text(
                    "How fast can you deliver?",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16.0,
                        color: Colors.black,fontWeight: FontWeight.w500),
                  ),
                  subtitle:Text(
                    "Order placed will be delivered next day.",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 12.0,
                        color: Colors.black),
                  ) ,
                ),
              ),
            ),Card(
              elevation: 4.0,

              color: Colors.white,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, right: 5.0, left: 5.0),
                child: ListTile(
                  title: Text(
                    "What if i had any query?",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16.0,
                        color: Colors.black,fontWeight: FontWeight.w500),
                  ),
                  subtitle:Text(
                    "For query mail us to info@terasol.in",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 12.0,
                        color: Colors.black),
                  ) ,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
