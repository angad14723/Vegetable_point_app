import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetable_point/Constants.dart';
import 'package:vegetable_point/podo/CategoryData.dart';

class WebService {
  static Future<List<CategoryList>> getFutureData() async {
    try {
      List<CategoryList> list;
      String url =
          "http://test.terasol.in/vegetable_point/api/category/read.php";

      final response = await http.get(url);

      if (response.statusCode == 200) {
        var parsed =
            json.decode(response.body)['data'].cast<Map<String, dynamic>>();

        print("parsedJson2 ${parsed}");

        //parsed.map<CategoryList>((json) => CategoryList.fromJson(json)).toList();
        //list = parsed.map<CategoryList>((json) => CategoryList.fromJson(json)).toList();

        fetchDatatoLocal(response.body);

        list = getCategoryList(parsed);

        return list;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<CategoryList> getCategoryList(parsed) {

    List<CategoryList> categoryList = new List();

    categoryList = parsed
        .map<CategoryList>((json) => CategoryList.fromJson(json))
        .toList();

    return categoryList;
  }

  static void fetchDatatoLocal(String response) async {
    final sharedPref = await SharedPreferences.getInstance();

    var login_flag = sharedPref.getBool(Constants().LOGIN_FLAG) ?? false;
    sharedPref.setBool(Constants().LOGGED_IN, false);

    if (!login_flag) {

    sharedPref.setBool(Constants().LOGIN_FLAG, true);

    sharedPref.setString(Constants().LOCAL_JSON, response);

    var localData = sharedPref.getString(Constants().LOCAL_JSON) ?? "";

    print("localJson ${localData}");

    var decodedLocal = json.decode(localData)["data"];

    print("decoded data =$decodedLocal");

    var encodedLocal = json.encode(decodedLocal);

    print("encoded data ${encodedLocal}");
    /*todo operation on local data*/

    for (int i = 0; i < decodedLocal.length; i++) {
      print("loop i : = ${decodedLocal[i]["name"]}");

      for (int j = 0; j < decodedLocal[i]["sub_category"].length; j++) {
        for (int k = 0;
            k < decodedLocal[i]["sub_category"][j]["products"].length;
            k++) {
          if (k  >= 0) {

            decodedLocal[i]["sub_category"][j]["products"][k]["itemCount"] = 0;
            decodedLocal[i]["sub_category"][j]["products"][k]["total_amount"]=0;

            print(
                "loop k : =${decodedLocal[i]["sub_category"][j]["products"][k]}");
          }
        }
      }
    }

    sharedPref.setString(Constants().LOCAL_JSON, json.encode(decodedLocal));

    var prefDataTest = sharedPref.getString(Constants().LOCAL_JSON ?? "");

    print("localJson2 ${prefDataTest}");

    var prefDataDecoded = json.decode(prefDataTest);

    for (int i = 0; i < prefDataDecoded.length; i++) {

      print("loop i2 : = ${prefDataDecoded[i]["name"]}");

      for (int j = 0; j < prefDataDecoded[i]["sub_category"].length; j++) {
        for (int k = 0;
            k < prefDataDecoded[i]["sub_category"][j]["products"].length;
            k++) {
          print("loop k2 : =${prefDataDecoded[i]["sub_category"][j]["products"][k]}");

        }
      }
    }

     }
  }
}
