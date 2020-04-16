class AddressData {
  int id;
  String houseNo;
  String locality;
  String areaName;
  String city;
  String state;
  String pinCode;
  String homeOffice;
  int isSelected;

  AddressData(this.id, this.houseNo, this.locality, this.areaName, this.city,
      this.state, this.pinCode, this.homeOffice,this.isSelected);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'houseNo': houseNo,
      'locality': locality,
      'areaName': areaName,
      'city': city,
      'state': state,
      'pinCode': pinCode,
      'homeOffice': homeOffice,
      'isSelected':isSelected,
    };
    return map;
  }

  AddressData.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    houseNo = map['houseNo'];
    locality=map['locality'];
    areaName=map['areaName'];
    city=map['city'];
    state=map['state'];
    pinCode=map['pinCode'];
    homeOffice=map['homeOffice'];
    isSelected=map['isSelected'];

  }

}
