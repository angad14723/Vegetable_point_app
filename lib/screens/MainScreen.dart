import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetable_point/Constants.dart';
import 'package:vegetable_point/podo/CategoryData.dart';
import 'package:vegetable_point/screens/AddressFile.dart';
import 'package:vegetable_point/screens/FAQ.dart';
import 'package:vegetable_point/screens/MyAddressesScreen.dart';
import 'package:vegetable_point/screens/ProductsScreen.dart';
import 'package:vegetable_point/screens/secreen_item/Category_Item.dart';
import 'package:vegetable_point/styles/AppColors.dart';
import 'package:vegetable_point/webservices/WebServices.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'CheckOutScreen.dart';

class HomeClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeClassState();
  }
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            style: TextStyle(fontFamily: "Raleway"),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}

Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('images/carrot.png'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Vegetable Point",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}

Widget _createDrawer(BuildContext context, bool loggedIn) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        _createHeader(),
        _createDrawerItem(
            icon: Icons.account_balance,
            text: 'Address',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyAddressClass(),
                  ));
            }),
        _createDrawerItem(
            icon: Icons.local_grocery_store, text: 'My Orders', onTap: () {}),
        Divider(),
        _createDrawerItem(
            icon: Icons.contact_phone,
            text: 'Contact Us',
            onTap: () {
              UrlLauncher.launch("tel://+918051313132");
            }),
        _createDrawerItem(
            icon: Icons.announcement,
            text: 'Facts',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FAQclass(),
                  ));
            }),
        loggedIn
            ? _createDrawerItem(
                icon: Icons.power_settings_new, text: 'Logout', onTap: () {})
            : _createDrawerItem(
                icon: Icons.power_settings_new,
                text: 'Login',
                onTap: () {
                  Navigator.of(context).pop();
                  __openCustomDialog(context);
                }),
      ],
    ),
  );
}

__openCustomDialog(BuildContext context) {
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

class HomeClassState extends State<HomeClass> {
  bool isExpanded = false;
  var categoryLength;
  bool loggedIn = false;

  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    "http://bloomingtrenz.com/wp-content/uploads/2018/03/Deal-Post-Banner.jpg",
    "https://previews.123rf.com/images/olhakostiuk/olhakostiuk1707/olhakostiuk170700046/82662002-spring-sale-banner-for-online-shopping-with-discount-offer-promotional-email-design-poster-pink-abst.jpg",
    "https://previews.123rf.com/images/vectorgift/vectorgift1608/vectorgift160800109/61622829-sale-discount-background-for-the-online-store-shop-promotional-leaflet-promotion-poster-banner-vecto.jpg",
    "https://previews.123rf.com/images/vectorgift/vectorgift1608/vectorgift160800109/61622829-sale-discount-background-for-the-online-store-shop-promotional-leaflet-promotion-poster-banner-vecto.jpg",
    "https://i.gadgets360cdn.com/large/flipkart_main1_1543824241899.jpg?output-quality=80",
  ];

  @override
  void initState() {
    super.initState();

    getSharedPrefData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.PRIMARY_COLOR,
          title: Text(
            "Home",
            style: TextStyle(fontFamily: "Raleway"),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () {
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
        drawer: _createDrawer(context, loggedIn),
        body: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate([
                /* ClipRect(
                  child: Banner(
                      message: "hello",
                      location: BannerLocation.topEnd,
                      color: Colors.red,
                      child: Card(
                        margin: const EdgeInsets.all(10.0),
                        elevation: 2.0,
                        child: Container(
                          color: Colors.yellow,
                          height: 150,
                          child: Center(
                            child: Text(
                              "Hello, banner!",
                              style: TextStyle(fontFamily: "Raleway"),
                            ),
                          ),
                        ),
                      )),
                ),*/
                _createCarouselDrawer(),
              ])),
              SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1),
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
                        child: FutureBuilder<List<CategoryList>>(
                            future: WebService.getFutureData(),
                            // future: WebServiceSubCategory.getSubCategory(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error ${snapshot.error}');
                              }
                              if (snapshot.hasData) {
                                return Category_Item(
                                    context, snapshot.data[index]);
                                // return SubCategory_Item(context,snapshot.data[index]);
                              }

                              return circularProgress();
                            }));
                  }, childCount: 6)),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                return Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: FutureBuilder<List<CategoryList>>(
                      future: WebService.getFutureData(),
                      //future: WebServiceSubCategory.getSubCategory(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {

                          List<CategoryList> data = snapshot.data;

                          return ExpansionTile(
                            onExpansionChanged: (bool expanding) =>
                                setState(() => this.isExpanded = expanding),
                            title: Text(
                              data[index].name,
                              style: TextStyle(
                                  fontFamily: "Raleway",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            children: data[index]
                                .sucategoryList
                                .map((subCatData) => Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductClass(
                                                      subCatData.name,
                                                      subCatData.productsList,
                                                      data[index].name),
                                            ));

                                        /*Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(subCatData.name),
                                        ));*/
                                      },
                                      leading: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.PRIMARY_COLOR),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          child: Image.asset(
                                              "images/vegetable.png"),
                                        ),
                                      ),
                                      title: Text(
                                        subCatData.name,
                                        style: TextStyle(
                                            fontFamily: "Raleway",
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      subtitle: Text(
                                        "a subtitle here",
                                        style: TextStyle(
                                            fontFamily: "Raleway",
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )))
                                .toList(),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return circularProgress();
                      },
                    ));
              }, childCount: 6)),
            ],
          ),
        ));
  }

  void getSharedPrefData() async {
    final sharedPref = await SharedPreferences.getInstance();

    loggedIn = sharedPref.getBool(Constants().LOGGED_IN ?? false);

    print("LoggedIn ${loggedIn}");
  }

  _createCarouselDrawer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          carouselSlider = CarouselSlider(
            height: 200.0,
            initialPage: 0,
            enlargeCenterPage: true,
            autoPlay: true,
            reverse: false,
            enableInfiniteScroll: true,
            autoPlayInterval: Duration(seconds: 20),
            autoPlayAnimationDuration: Duration(milliseconds: 4000),
            pauseAutoPlayOnTouch: Duration(seconds: 20),
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
            items: imgList.map((imgUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                    ),
                    child: Image.network(
                      imgUrl,
                      fit: BoxFit.fill,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(imgList, (index, url) {
              return Container(
                width: 5.0,
                height: 5.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.redAccent : Colors.green,
                ),
              );
            }),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}

circularProgress() {
  return Center(
    child: const CircularProgressIndicator(),
  );
}
