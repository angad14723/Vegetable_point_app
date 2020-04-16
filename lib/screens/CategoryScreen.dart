import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vegetable_point/podo/CategoryData.dart';
import 'package:vegetable_point/screens/ProductsScreen.dart';
import 'package:vegetable_point/screens/secreen_item/Category_Item.dart';
import 'package:vegetable_point/screens/secreen_item/SubCategory_Item.dart';
import 'package:vegetable_point/styles/AppColors.dart';
import 'package:vegetable_point/webservices/WebServices.dart';

import 'CheckOutScreen.dart';

class CategoryScreen extends StatefulWidget {

  CategoryScreen(this.titleName, this.catList);

  String titleName;
  CategoryList catList;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryStateScreen();
  }
}

class CategoryStateScreen extends State<CategoryScreen> {
  final List<String> images = [
    "https://uae.microless.com/cdn/no_image.jpg",
    "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
    "https://www.boostmobile.com/content/dam/boostmobile/en/products/phones/apple/iphone-7/silver/device-front.png.transform/pdpCarousel/image.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgUgs8_kmuhScsx-J01d8fA1mhlCR5-1jyvMYxqCB8h3LCqcgl9Q",
    /* "https://ae01.alicdn.com/kf/HTB11tA5aiAKL1JjSZFoq6ygCFXaw/Unlocked-Samsung-GALAXY-S2-I9100-Mobile-Phone-Android-Wi-Fi-GPS-8-0MP-camera-Core-4.jpg_640x640.jpg",
    "https://media.ed.edmunds-media.com/gmc/sierra-3500hd/2018/td/2018_gmc_sierra-3500hd_f34_td_411183_1600.jpg",
    "https://hips.hearstapps.com/amv-prod-cad-assets.s3.amazonaws.com/images/16q1/665019/2016-chevrolet-silverado-2500hd-high-country-diesel-test-review-car-and-driver-photo-665520-s-original.jpg",
    "https://www.galeanasvandykedodge.net/assets/stock/ColorMatched_01/White/640/cc_2018DOV170002_01_640/cc_2018DOV170002_01_640_PSC.jpg",
    "https://media.onthemarket.com/properties/6191869/797156548/composite.jpg",
    "https://media.onthemarket.com/properties/6191840/797152761/composite.jpg",*/
  ];
  final List<String> images2 = [
    "https://uae.microless.com/cdn/no_image.jpg",
    "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
    "https://www.boostmobile.com/content/dam/boostmobile/en/products/phones/apple/iphone-7/silver/device-front.png.transform/pdpCarousel/image.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgUgs8_kmuhScsx-J01d8fA1mhlCR5-1jyvMYxqCB8h3LCqcgl9Q",
    "https://ae01.alicdn.com/kf/HTB11tA5aiAKL1JjSZFoq6ygCFXaw/Unlocked-Samsung-GALAXY-S2-I9100-Mobile-Phone-Android-Wi-Fi-GPS-8-0MP-camera-Core-4.jpg_640x640.jpg",
    /*"https://media.ed.edmunds-media.com/gmc/sierra-3500hd/2018/td/2018_gmc_sierra-3500hd_f34_td_411183_1600.jpg",
    "https://hips.hearstapps.com/amv-prod-cad-assets.s3.amazonaws.com/images/16q1/665019/2016-chevrolet-silverado-2500hd-high-country-diesel-test-review-car-and-driver-photo-665520-s-original.jpg",
    "https://www.galeanasvandykedodge.net/assets/stock/ColorMatched_01/White/640/cc_2018DOV170002_01_640/cc_2018DOV170002_01_640_PSC.jpg",
    "https://media.onthemarket.com/properties/6191869/797156548/composite.jpg",
    "https://media.onthemarket.com/properties/6191840/797152761/composite.jpg",*/
  ];
  int catItemCount;

  List<SubCategory> subCategoryList=new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("itemCount ${widget.catList.sucategoryList.length}");

    catItemCount = widget.catList.sucategoryList.length;

    getSubCategoryList();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        title: Text(
          widget.titleName,
          style: TextStyle(fontFamily: "Raleway"),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: (){

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckOutClass(),
                      ));
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.local_grocery_store,
                    color: Colors.white,
                  ),
                ),
              ))
        ],
      ),
      body: _createStaggeredGridView(),
    );
  }

  Widget _createStaggeredGridView() {
    return Center(
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: catItemCount,
        itemBuilder: (BuildContext context, int index) => Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.PRIMARY_COLOR),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                alignment: Alignment.center,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                     Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductClass(subCategoryList[index].name,subCategoryList[index].productsList,widget.titleName),
                  ));
                   /* Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(widget.catList.sucategoryList[index].name),
                    ));*/
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            child: Image.network(
                          catItemCount == 4 ? images[index] : images2[index],
                        )),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Text(
                       // widget.catList.sucategoryList[index].name,
                        subCategoryList[index].name,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontFamily: "Raleway"),
                      ),
                    ],
                  ),
                ))),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  void getSubCategoryList() {
    for (int i = 0; i < widget.catList.sucategoryList.length; i++) {
      if (widget.titleName == widget.catList.name) {
        subCategoryList.add(widget.catList.sucategoryList[i]);
      }
    }
  }

}
