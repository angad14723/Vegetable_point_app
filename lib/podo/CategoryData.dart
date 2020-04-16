import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CategoryList {
  String id;
  String name;
  List<SubCategory> sucategoryList;

  CategoryList({this.id, this.name, this.sucategoryList});

  factory CategoryList.fromJson(Map<String, dynamic> json) {
    return CategoryList(
      id: json['id'],
      name: json['name'],
      sucategoryList: (json["sub_category"] as List)
          .map((value) => SubCategory.fromJson(value))
          .toList(),
    );
  }
}

class SubCategory {
  String id;
  String name;
  List<Products> productsList;

  SubCategory({this.id, this.name, this.productsList});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      productsList: (json["products"] as List)
          .map((value) => Products.fromJson(value))
          .toList(),
    );
  }
}

class Products {
  String id;
  String name;
  String image;
  String price_per_quantity;
  String discounted_price;
  String total_quantity;
  String itemCount;
  String totalAmount;
  String category_id;
  String sub_category_id;

  Products(
      {this.id,
      this.name,
      this.image,
      this.price_per_quantity,
      this.discounted_price,
      this.total_quantity,
      this.itemCount,
      this.totalAmount,
      this.category_id,
      this.sub_category_id});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      price_per_quantity: json["price_per_quantity"],
      discounted_price: json["discounted_price"],
      total_quantity: json["total_quantity"],
      itemCount: json["itemCount"],
      totalAmount: json["total_amount"],
      category_id: json["category_id"],
      sub_category_id: json["sub_category_id"],
    );
  }
}
