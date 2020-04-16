import 'package:flutter/material.dart';
import 'package:vegetable_point/podo/AddressData.dart';
import 'package:vegetable_point/sqlite/DBHelper.dart';
import 'package:vegetable_point/styles/AppColors.dart';

class PersonalDetailClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StatePersonalDetail();
  }
}

class StatePersonalDetail extends State<PersonalDetailClass> {
  Future<List<AddressData>> addressDataList;
  DBHelper dbHelper;

  List<LocalAddress> localAddewssList = new List();

  @override
  void initState() {
    super.initState();

    dbHelper = DBHelper();

    refreshAddress();
  }

  void refreshAddress() {
    setState(() {
      addressDataList = dbHelper.getAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        title: Text(
          "Personal Detail",
          style: TextStyle(fontFamily: "Raleway"),
        ),
        actions: <Widget>[
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
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: _createBody(),
    );
  }

  _createBody() {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[

          FutureBuilder(
            future: addressDataList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<AddressData> addressList = snapshot.data;

                print("snapshotLength ${snapshot.data.length}");

                for (int i = 0; i < addressList.length; i++) {
                  if (addressList[i].isSelected == 1) {
                    print("addressListItem ${addressList[i].houseNo}");

                    localAddewssList.add(LocalAddress(
                        addressList[i].id,
                        addressList[i].houseNo,
                        addressList[i].locality,
                        addressList[i].areaName,
                        addressList[i].city,
                        addressList[i].state,
                        addressList[i].pinCode,
                        addressList[i].homeOffice,
                        addressList[i].isSelected));
                  }
                }

                return Card(
                  child:Padding(padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                  child: ListTile(
                    title: Text(
                      localAddewssList[0].houseNo,
                      style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      ("${localAddewssList[0].locality + " , " + localAddewssList[0].areaName + "\n" + localAddewssList[0].city+" , "+localAddewssList[0].pinCode}"),
                      style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){

                    }),
                  ),
                ));
              }
              if (snapshot.data == null || snapshot.data.length == 0) {
                return SizedBox(
                  width: 20,
                );
              }
              return SizedBox(width: 20,);
            },
          ),

        ],
      ),
    ));
  }
}

class LocalAddress {
  int id;
  String houseNo;
  String locality;
  String areaName;
  String city;
  String state;
  String pinCode;
  String homeOffice;
  int isSelected;

  LocalAddress(this.id, this.houseNo, this.locality, this.areaName, this.city,
      this.state, this.pinCode, this.homeOffice, this.isSelected);
}
