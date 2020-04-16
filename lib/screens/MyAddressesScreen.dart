import 'package:flutter/material.dart';
import 'package:vegetable_point/podo/AddressData.dart';
import 'package:vegetable_point/screens/AddressFile.dart';
import 'package:vegetable_point/sqlite/DBHelper.dart';
import 'package:vegetable_point/styles/AppColors.dart';

class MyAddressClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateMyAddress();
  }
}

class StateMyAddress extends State<MyAddressClass> {
  DBHelper dbHelper;
  Future<List<AddressData>> address;

  String addressName;
  bool isChecked;

  int currentListValue = 1;

  @override
  void initState() {
    super.initState();

    dbHelper = DBHelper();
    refreshData();
  }

  void refreshData() {
    setState(() {
      address = dbHelper.getAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        title: Text(
          "Address",
          style: TextStyle(fontFamily: "Raleway"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddressClass(),
              )).then((onValue) {
            refreshData();
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: _createBody(),
    );
  }

  _createBody() {
    return Center(
      child: FutureBuilder(
        future: address,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("snapshot Data");
            List<AddressData> addressList = snapshot.data;
            for (int i = 0; i < addressList.length; i++) {
              if (addressList[i].isSelected == 1) {
                currentListValue = addressList[i].id;
              }
            }
            return ListView(
              children: addressList
                  .map((data) => Padding(
                      padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Card(
                          child: Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: RadioListTile(
                                activeColor: AppColors.PRIMARY_COLOR,
                                groupValue: currentListValue,
                                value: data.id,
                                onChanged: (val) {
                                  setState(() {
                                    currentListValue = val;

                                    for (int i = 0;
                                        i < addressList.length;
                                        i++) {
                                      var status = addressList[i].isSelected;

                                      if (status == 1) {
                                        dbHelper.update(AddressData(
                                            addressList[i].id,
                                            addressList[i].houseNo,
                                            addressList[i].locality,
                                            addressList[i].areaName,
                                            addressList[i].city,
                                            addressList[i].state,
                                            addressList[i].pinCode,
                                            addressList[i].homeOffice,
                                            0));
                                      }
                                    }

                                    dbHelper.update(AddressData(
                                        data.id,
                                        data.houseNo,
                                        data.locality,
                                        data.areaName,
                                        data.city,
                                        data.state,
                                        data.pinCode,
                                        data.homeOffice,
                                        1));

                                    refreshData();
                                  });
                                },
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "${data.houseNo}",
                                          style: TextStyle(
                                              fontFamily: "Raleway",
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "${data.locality + " , " + data.areaName}",
                                          style: TextStyle(
                                              fontFamily: "Raleway",
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "${data.city + " , " + data.state + "\n" + data.pinCode}",
                                          style: TextStyle(
                                              fontFamily: "Raleway",
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete_outline),
                                      onPressed: () {
                                        _showDialog(data.id);
                                      },
                                    ),
                                  ],
                                ),
                                /*subtitle: Text(
                          "${data.city + "," + data.state + "," + data.pinCode}",
                          style: TextStyle(
                              fontFamily: "Raleway",
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500),
                        ),*/

                                /*trailing: IconButton(
                          icon: Icon(Icons.delete_outline),
                          onPressed: () {
                            _showDialog(data.id);
                          },
                        ),*/
                              )))))
                  .toList(),
            );
          }
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text('No Data Found');
          }
          return Text('No Data Found');
        },
      ),
    );
  }

  void _showDialog(int id) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Are you sure?"),
          content: new Text("Do you want to delete it?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                dbHelper.delete(id);
                refreshData();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
