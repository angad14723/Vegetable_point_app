import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetable_point/Constants.dart';
import 'package:vegetable_point/podo/CategoryData.dart';
import 'package:vegetable_point/screens/CheckOutScreen.dart';
import 'package:vegetable_point/styles/AppColors.dart';
import 'dart:math';

class ProductClass extends StatefulWidget {
  ProductClass(this.subCatName, this.productList, this.catName);

  String subCatName;
  String catName;

  String backPressed;

  List<Products> productList;

  @override
  State<StatefulWidget> createState() {
    return StateProducts();
  }
}

class StateProducts extends State<ProductClass> {
  int productItemCounter;
  List<int> totalAmountList = new List();
  List<String> totalCountList = new List();
  List<ProductsList> prefProductList = new List();
  List<Products> productsList;

  int itemCount;
  num totalAmount = 0;

  @override
  void initState() {
    super.initState();
    getAddedProducts();
    getTotalAmount();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        title: Text(
          widget.subCatName,
          style: TextStyle(fontFamily: "Raleway"),
        ),
      ),
      body: //widget.productList.length > 0
          prefProductList.length > 0
              ? _createProductBody()
              : _createEmptyState(),
      bottomNavigationBar: totalAmount > 0 ? _createAppBottomBar() : null,
    );
  }

  Widget _createProductBody() {
    return Center(
      child: ListView.builder(
        itemCount: productItemCounter,
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
                    prefProductList[index].name,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w500),
                  ),
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(prefProductList[index].image),
                    //widget.productList[index].image),
                    backgroundColor: Colors.transparent,
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        prefProductList[index].discounted_price,
                        //"Rs " + widget.productList[index].discounted_price,
                        style: TextStyle(fontSize: 12.0, fontFamily: "Raleway"),
                      ),
                      Text(
                        prefProductList[index].price_per_quantity,
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
                              totalAmountList.remove(int.parse(
                                  prefProductList[index].discounted_price));
                              print("totalAmountRemove ${totalAmountList}");

                              totalAmount = 0;
                              for (int l = 0; l < totalAmountList.length; l++) {
                                totalAmount += totalAmountList[l];
                              }
                              print("totalAmountNum ${totalAmount}");

                              removeFromTotalAmount(prefProductList[index].name,
                                  prefProductList[index].discounted_price);
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
                        prefProductList[index].itemCount.toString(),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              totalAmountList.add(int.parse(
                                  prefProductList[index].discounted_price));

                              print("totalAmountListAdd ${totalAmountList}");

                              totalAmount = 0;
                              for (int l = 0; l < totalAmountList.length; l++) {
                                totalAmount += totalAmountList[l];
                              }
                              print("totalAmountNum ${totalAmount}");

                              addTotalAmount(prefProductList[index].name,
                                  prefProductList[index].discounted_price);
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
      ),
    );
  }

  _createEmptyState() {
    return Container(
      child: Center(
        child: Text("Empty state!"),
      ),
    );
  }

  _createAppBottomBar() {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          padding: EdgeInsets.only(right: 20.0, left: 20.0),
          height: 60.0,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckOutClass()))
                        .then((onValue) {
                      totalAmountList.clear();
                      totalAmount = 0;
                      prefProductList.clear();

                      getAddedProducts();
                      getTotalAmount();
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.local_grocery_store,
                              color: AppColors.PRIMARY_COLOR,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.PRIMARY_COLOR),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                color: Colors.white),
                            child: Text(
                              totalAmountList.length.toString(),
                              style: TextStyle(fontSize: 12.0),
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: Text(
                          "Rs " + totalAmount.toString(),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckOutClass()))
                        .then((onValue) {
                      totalAmountList.clear();
                      totalAmount = 0;
                      prefProductList.clear();

                      getAddedProducts();
                      getTotalAmount();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: AppColors.PRIMARY_COLOR),
                    child: Text(
                      "Check-Out",
                      style:
                          TextStyle(fontFamily: "Raleway", color: Colors.white),
                    ),
                  )),
            ],
          ),
        ));
  }

  Future<List<ProductsList>> getAddedProducts() async {
    final sharedPref = await SharedPreferences.getInstance();
    var PrefData = sharedPref.getString(Constants().LOCAL_JSON ?? "");
    var decodedData = json.decode(PrefData);

    debugPrint("PrefData3 ${decodedData}");

    for (int i = 0; i < decodedData.length; i++) {
      var catData = decodedData[i];

      print("catadata ${catData}");

      if (widget.catName == catData["name"]) {
        print("categoryName ${catData["name"]}");

        for (int j = 0; j < catData["sub_category"].length; j++) {
          var sub_category = catData["sub_category"][j];

          if (widget.subCatName == sub_category["name"]) {
            print("sub_category  ${sub_category["name"]}");

            for (int k = 0; k < sub_category["products"].length; k++) {
              var products = sub_category["products"][k];

              // print("productsItems ${products}");

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

                prefProductList.add(productsData);
                productItemCounter = prefProductList.length;
              });
            }
          }
        }
      }
    }

    return prefProductList;
  }

  void addTotalAmount(String productName, String price) async {
    final sharedPref = await SharedPreferences.getInstance();

    var PrefData = sharedPref.getString(Constants().LOCAL_JSON ?? "");

    var decodedData = json.decode(PrefData);

    for (int i = 0; i < decodedData.length; i++) {
      var catData = decodedData[i];

      if (widget.catName == catData["name"]) {
        for (int j = 0; j < catData["sub_category"].length; j++) {
          var sub_category = catData["sub_category"][j];

          if (widget.subCatName == sub_category["name"]) {
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
      prefProductList.clear();

      getAddedProducts();
    });
  }

  void removeFromTotalAmount(String productName, String price) async {
    final sharedPref = await SharedPreferences.getInstance();

    var PrefData = sharedPref.getString(Constants().LOCAL_JSON ?? "");

    var decodedData = json.decode(PrefData);

    for (int i = 0; i < decodedData.length; i++) {
      var catData = decodedData[i];

      if (widget.catName == catData["name"]) {
        for (int j = 0; j < catData["sub_category"].length; j++) {
          var sub_category = catData["sub_category"][j];

          if (widget.subCatName == sub_category["name"]) {
            for (int k = 0; k < sub_category["products"].length; k++) {
              var products = sub_category["products"][k];

              if (productName == products["name"]) {
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
      prefProductList.clear();
      getAddedProducts();
    });
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
}

class ProductsList {
  String id,
      name,
      image,
      price_per_quantity,
      discounted_price,
      total_quantity,
      category_id,
      sub_category_id;

  int itemCount, totalAmount;

  ProductsList(
      this.id,
      this.name,
      this.image,
      this.price_per_quantity,
      this.discounted_price,
      this.total_quantity,
      this.itemCount,
      this.totalAmount,
      this.category_id,
      this.sub_category_id);
}
