import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vegetable_point/podo/AddressData.dart';
import 'package:vegetable_point/sqlite/DBHelper.dart';
import 'package:vegetable_point/styles/AppColors.dart';

class AddressClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateAddressClass();
  }
}

class StateAddressClass extends State<AddressClass> {
  DBHelper dbHelper;
  String _houseNo, _locality, _areaName, _city, _state, _homeOffice;
  String _pinCode;

  final _houseNoController = TextEditingController();
  final _localityController = TextEditingController();
  final _areaNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _homeOfficeController = TextEditingController();
  final _pinCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Address",
          style: TextStyle(fontFamily: "Raleway"),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: _createAddressBody(),
    );
  }

  _createAddressBody() {
    return Center(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: TextFormField(
                    maxLength: 10,
                    maxLines: 1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Student Name';
                      }
                      if (value.trim() == "")
                        return "Only Space is Not Valid!!!";
                      return null;
                    },
                    onSaved: (value) {
                      _houseNo = value;
                    },
                    controller: _houseNoController,
                    decoration: InputDecoration(
                        labelText: "House No.",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.green),
                        )),
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: TextFormField(
                    maxLength: 15,
                    maxLines: 1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Student Name';
                      }
                      if (value.trim() == "")
                        return "Only Space is Not Valid!!!";
                      return null;
                    },
                    onSaved: (value) {
                      _locality = value;
                    },
                    controller: _localityController,
                    decoration: InputDecoration(
                        labelText: "Locality",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.green),
                        )),
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: TextFormField(
                    maxLength: 15,
                    maxLines: 1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Student Name';
                      }
                      if (value.trim() == "")
                        return "Only Space is Not Valid!!!";
                      return null;
                    },
                    onSaved: (value) {
                      _areaName = value;
                    },
                    controller: _areaNameController,
                    decoration: InputDecoration(
                        labelText: "Area Name",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.green),
                        )),
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: TextFormField(
                    maxLength: 20,
                    maxLines: 1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Student Name';
                      }
                      if (value.trim() == "")
                        return "Only Space is Not Valid!!!";
                      return null;
                    },
                    onSaved: (value) {
                      _city = value;
                    },
                    controller: _cityController,
                    decoration: InputDecoration(
                        labelText: "City",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.green),
                        )),
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: TextFormField(
                    maxLength: 20,
                    maxLines: 1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Student Name';
                      }
                      if (value.trim() == "")
                        return "Only Space is Not Valid!!!";
                      return null;
                    },
                    onSaved: (value) {
                      _state = value;
                    },
                    controller: _stateController,
                    decoration: InputDecoration(
                        labelText: "State",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.green),
                        )),
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: TextFormField(
                    maxLength: 6,
                    maxLines: 1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Student Name';
                      }
                      if (value.trim() == "")
                        return "Only Space is Not Valid!!!";
                      return null;
                    },
                    onSaved: (value) {
                      _pinCode = value;
                    },
                    controller: _pinCodeController,
                    decoration: InputDecoration(
                        labelText: "PinCode",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.green),
                        )),
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8.0, top: 5.0),
                  child: Text(
                    "Name of address",
                    style: new TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: TextFormField(
                    maxLength: 10,
                    maxLines: 1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Student Name';
                      }
                      if (value.trim() == "")
                        return "Only Space is Not Valid!!!";
                      return null;
                    },
                    onSaved: (value) {
                      _homeOffice = value;
                    },
                    controller: _homeOfficeController,
                    decoration: InputDecoration(
                        labelText: "Ex. Home,Office",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.green),
                        )),
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20.0, right: 10.0, left: 10.0),
                    padding: EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0, left: 20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        color: AppColors.PRIMARY_COLOR),
                    child: Text(
                      "Save Address",
                      style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: () {
                    if (_houseNoController.text.trim() == "") {
                      Fluttertoast.showToast(
                          msg: "Enter House No.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          textColor: Colors.black,
                          fontSize: 12.0);
                    } else if (_localityController.text.trim() == "") {
                      Fluttertoast.showToast(
                          msg: "Enter Locality",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          textColor: Colors.black,
                          fontSize: 12.0);
                    } else if (_areaNameController.text.trim() == "") {
                      Fluttertoast.showToast(
                          msg: "Enter Area",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          textColor: Colors.black,
                          fontSize: 12.0);
                    } else if (_cityController.text.trim() == "") {
                      Fluttertoast.showToast(
                          msg: "Enter City",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          textColor: Colors.black,
                          fontSize: 12.0);
                    } else if (_stateController.text.trim() == "") {
                      Fluttertoast.showToast(
                          msg: "Enter State",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          textColor: Colors.black,
                          fontSize: 12.0);
                    } else if (_pinCodeController.text.trim() == "") {
                      Fluttertoast.showToast(
                          msg: "Enter Pincode",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          textColor: Colors.black,
                          fontSize: 12.0);
                    } else if (_homeOfficeController.text.trim() == "") {
                      Fluttertoast.showToast(
                          msg: "Enter Name of the Address",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          textColor: Colors.black,
                          fontSize: 12.0);
                    } else {

                      print("address Data ${_homeOfficeController.text}");

                      dbHelper.add(AddressData(null, _houseNoController.text, _localityController.text,
                          _areaNameController.text, _cityController.text, _stateController.text, _pinCodeController.text,
                          _homeOfficeController.text,1));

                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            )));
  }
}
