import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vegetable_point/podo/CategoryData.dart';
import 'package:vegetable_point/screens/CategoryScreen.dart';
import 'package:vegetable_point/styles/AppColors.dart';

class Category_Item extends StatelessWidget {

  const Category_Item(this.context, this.categoryList);

  @required
  final BuildContext context;

  final CategoryList categoryList;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
          alignment: Alignment.center,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(categoryList.name,categoryList),
                  ));

              /* Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(categoryList.name),
              ));*/
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.PRIMARY_COLOR),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Image.asset("images/carrot.png"),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Text(
                  categoryList.name,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontFamily: "Raleway"),
                ),
              ],
            ),
          ),
        ));
  }
}
