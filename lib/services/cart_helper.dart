import 'dart:convert';
import 'package:ecommerce_app/models/add_to_cart.dart';
import 'package:ecommerce_app/models/orders/orders_res.dart';
import 'package:ecommerce_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/get_products.dart';

class CartHelper {
  Future<bool> addToCart(AddToCart model) async {
    //pass the token so we can get the profile
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "token": "Bearer $token"
    };
    var url = Uri.http(Config.apiUrl, Config.addCartUrl);
    var response = await http.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //the return type of the function doesnt have to match the return type of the response
  Future<List<Product>> getCart() async {
    //pass the token so we can get the profile
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "token": "Bearer $token"
    };
    var url = Uri.http(Config.apiUrl, Config.getCartUrl);
    var response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      //decode the response.body (it is List of carts List<Map<String, dynamic>)
      final jsonData = json.decode(response.body);
      List<Product> cart = [];
      //after that we get the products list which is List<Map<String, dynamic>>
      final products = jsonData["products"];
      //we then wanna create a List<Product> by mapping each products inthe list which is a Map<String, dynamic> into Product type using Product.fromJson
      cart = List<Product>.from(
        products.map((product) => Product.fromJson(product)),
      );

      return cart;
    } else {
      throw Exception("Failed to get cart items");
    }
  }

  Future<bool> deleteItemCart(String cartItemId) async {
    //pass the token so we can get the profile
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "token": "Bearer $token"
    };
    var url = Uri.http(Config.apiUrl, "${Config.addCartUrl}/$cartItemId");
    var response = await http.delete(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PaidOrders>> getOrders() async {
    //pass the token so we can get the profile
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "token": "Bearer $token"
    };

    var url = Uri.http(Config.apiUrl, Config.ordersUrl);
    var response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      final products = paidOrdersFromJson(response.body);
      return products;
    } else {
      throw Exception("Failed to get orders");
    }
  }
}
