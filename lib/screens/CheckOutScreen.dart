import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetable_point/screens/AddressFile.dart';
import 'package:vegetable_point/screens/PersonalDetailScreen.dart';
import 'package:vegetable_point/screens/ProductsScreen.dart';
import 'package:vegetable_point/styles/AppColors.dart';

import '../Constants.dart';

class CheckOutClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CheckOutClassState();
  }
}

class CheckOutClassState extends State<CheckOutClass> {
  num totalAmount = 0;
  List<ProductsList> productList = new List();
  int itemCount;
  List<int> totalAmountList = new List();

  bool LOGGED_IN = false;

  @override
  void initState() {
    super.initState();

    getProductsForCheckOut();
    getTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        title: Text(
          "Checkout",
          style: TextStyle(fontFamily: "Raleway"),
        ),
        actions: <Widget>[
          Container(
            width: 15.0,
            height: 15.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          Container(
            width: 15.0,
            height: 15.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          Container(
            width: 15.0,
            height: 15.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: totalAmount == 0 ? _createEmptyState() : _createCheckOutBody(),
      bottomNavigationBar: _createCheckOutBottomBar(),
    );
  }

  _createEmptyState() {
    return Center(
      child: Container(
        child: Text("No Item Found!"),
      ),
    );
  }

  _createCheckOutBottomBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        padding: EdgeInsets.all(20),
        height: 180.0,
        color: Colors.transparent,
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontFamily: "Raleway"),
                  ),
                  Text(
                    "Rs " + totalAmount.toString() + ".00",
                    style: TextStyle(),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Shipping",
                    style: TextStyle(fontFamily: "Raleway"),
                  ),
                  Text(
                    "Rs 0.0",
                    style: TextStyle(),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Payable",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0),
                  ),
                  Text(
                    "Rs " + totalAmount.toString() + ".00",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              GestureDetector(
                  onTap: () {
                    LOGGED_IN = true;

                    if (totalAmount >= 200) {
                      if (LOGGED_IN) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonalDetailClass(),
                            ));
                      } else {
                        __openCustomDialog();
                      }
                    }else{

                      Fluttertoast.showToast(
                          msg: "Minimum amount will be 200",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          textColor: Colors.black,
                          fontSize: 12.0);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: AppColors.PRIMARY_COLOR),
                    child: Text(
                      "Continue Checkout",
                      style:
                          TextStyle(fontFamily: "Raleway", color: Colors.white),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _createCheckOutBody() {
    return Center(
        child: ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Container(
              margin: EdgeInsets.only(right: 10.0, left: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.PRIMARY_COLOR),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white),
              child: ListTile(
                title: Text(
                  // widget.productList[index].name,
                  productList[index].name,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w500),
                ),
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(productList[index].image),
                  //widget.productList[index].image),
                  backgroundColor: Colors.transparent,
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      productList[index].discounted_price,
                      //"Rs " + widget.productList[index].discounted_price,
                      style: TextStyle(fontSize: 12.0, fontFamily: "Raleway"),
                    ),
                    Text(
                      productList[index].price_per_quantity,
                      //"Rs " + widget.productList[index].price_per_quantity,
                      style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: "Raleway",
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            totalAmountList.remove(
                                int.parse(productList[index].discounted_price));
                            print("totalAmountRemove ${totalAmountList}");

                            totalAmount = 0;
                            for (int l = 0; l < totalAmountList.length; l++) {
                              totalAmount += totalAmountList[l];
                            }
                            print("totalAmountNum ${totalAmount}");

                            /*if (totalAmount == 0) {
                              Navigator.of(context).pop();
                            }*/
                            removeFromTotalAmount(
                                productList[index].name,
                                productList[index].discounted_price,
                                productList[index].category_id,
                                productList[index].sub_category_id);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              color: Colors.white),
                          child: Icon(Icons.remove),
                        )),
                    Text(
                      productList[index].itemCount.toString(),
                      style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            totalAmountList.add(
                                int.parse(productList[index].discounted_price));

                            print("totalAmountListAdd ${totalAmountList}");

                            totalAmount = 0;
                            for (int l = 0; l < totalAmountList.length; l++) {
                              totalAmount += totalAmountList[l];
                            }
                            print("totalAmountNum ${totalAmount}");

                            addTotalAmount(
                                productList[index].name,
                                productList[index].discounted_price,
                                productList[index].category_id,
                                productList[index].sub_category_id);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              color: Colors.white),
                          child: Icon(Icons.add),
                        ))
                  ],
                ),
              ),
            ));
      },
    ));
  }

  Future<List<ProductsList>> getProductsForCheckOut() async {
    final sharedPref = await SharedPreferences.getInstance();
    var PrefData = sharedPref.getString(Constants().LOCAL_JSON ?? "");
    var decodedData = json.decode(PrefData);

    LOGGED_IN = sharedPref.getBool(Constants().LOGGED_IN ?? false);

    debugPrint("PrefData4 ${decodedData}");

    for (int i = 0; i < decodedData.length; i++) {
      var catData = decodedData[i];

      print("catadata4 ${catData}");

      for (int j = 0; j < catData["sub_category"].length; j++) {
        var sub_category = catData["sub_category"][j];

        for (int k = 0; k < sub_category["products"].length; k++) {
          var products = sub_category["products"][k];

          if (products["itemCount"] != 0) {
            setState(() {
              ProductsList productsData = ProductsList(
                  products["id"],
                  products["name"],
                  products["image"],
                  products["price_per_quantity"],
                  products["discounted_price"],
                  products["total_quantity"],
                  products["itemCount"],
                  products["total_amount"],
                  products["category_id"],
                  products["sub_category_id"]);

              productList.add(productsData);
              itemCount = productList.length;
            });
          }
        }
      }
    }

    return productList;
  }

  void getTotalAmount() async {
    final sharedPref = await SharedPreferences.getInstance();
    var PrefData = sharedPref.getString(Constants().LOCAL_JSON ?? "");
    var decodedData = json.decode(PrefData);

    for (int i = 0; i < decodedData.length; i++) {
      var catData = decodedData[i];

      for (int j = 0; j < catData["sub_category"].length; j++) {
        var sub_category = catData["sub_category"][j];

        for (int k = 0; k < sub_category["products"].length; k++) {
          var products = sub_category["products"][k];

          print("productsItems ${products}");

          if (products["itemCount"] != 0) {
            for (int l = 0; l < products["itemCount"]; l++) {
              totalAmountList.add(int.parse(products["discounted_price"]));

              print("totalAmount ${totalAmountList}");
            }
          }
        }
      }
    }

    for (int l = 0; l < totalAmountList.length; l++) {
      totalAmount += totalAmountList[l];
    }
    print("totalAmountNum ${totalAmount}");
  }

  void addTotalAmount(String productName, String price, String category_id,
      String sub_category_id) async {
    final sharedPref = await SharedPreferences.getInstance();
    var PrefData = sharedPref.getString(Constants().LOCAL_JSON ?? "");

    var decodedData = json.decode(PrefData);

    for (int i = 0; i < decodedData.length; i++) {
      var catData = decodedData[i];

      if (category_id == catData["id"]) {
        // print("sucessful");
        for (int j = 0; j < catData["sub_category"].length; j++) {
          var sub_category = catData["sub_category"][j];

          if (sub_category_id == sub_category["id"]) {
            for (int k = 0; k < sub_category["products"].length; k++) {
              var products = sub_category["products"][k];

              if (productName == products["name"]) {
                products["itemCount"] = ((products["itemCount"]) + 1);

                products["total_amount"] =
                    (products["itemCount"]) * (int.parse(price));
              }
            }
          }
        }
      }
    }

    sharedPref.setString(Constants().LOCAL_JSON, json.encode(decodedData));

    setState(() {
      productList.clear();
      getProductsForCheckOut();
    });
  }

  void removeFromTotalAmount(String name, String price, String category_id,
      String sub_category_id) async {
    final sharedPref = await SharedPreferences.getInstance();

    var PrefData = sharedPref.getString(Constants().LOCAL_JSON ?? "");

    var decodedData = json.decode(PrefData);

    for (int i = 0; i < decodedData.length; i++) {
      var catData = decodedData[i];

      if (category_id == catData["id"]) {
        for (int j = 0; j < catData["sub_category"].length; j++) {
          var sub_category = catData["sub_category"][j];

          if (sub_category_id == sub_category["id"]) {
            for (int k = 0; k < sub_category["products"].length; k++) {
              var products = sub_category["products"][k];

              if (name == products["name"]) {
                if ((products["itemCount"]) > 0) {
                  products["itemCount"] = ((products["itemCount"]) - 1);
                  products["total_amount"] =
                      (products["itemCount"]) * (int.parse(price));
                }
              }
            }
          }
        }
      }
    }

    sharedPref.setString(Constants().LOCAL_JSON, json.encode(decodedData));

    setState(() {
      productList.clear();

      getProductsForCheckOut();
    });
  }

  __openCustomDialog() {
    showGeneralDialog(
        barrierColor: Colors.greenAccent.withOpacity(0.2),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.PRIMARY_COLOR),
                    borderRadius: BorderRadius.circular(10.0)),
                title: Text(
                  'Vegetable Point',
                  style: TextStyle(fontFamily: "Raleway"),
                ),
                content: Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Email",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.green),
                        )),
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: new Text(
                      "Cancel",
                      style: TextStyle(
                          color: AppColors.ACCENT_COLOR,
                          fontFamily: "Raleway",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: new Text(
                      "Submit",
                      style: TextStyle(
                          color: AppColors.PRIMARY_COLOR,
                          fontFamily: "Raleway",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddressClass(),
                          ));
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }
}
