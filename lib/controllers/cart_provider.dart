import 'package:ecommerce_app/models/get_products.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CartNotifier with ChangeNotifier {

  int? _selectedProductCheckoutIndex;

  int get selectedProductCheckoutIndex => _selectedProductCheckoutIndex ?? 0;

  set selectedProductCheckoutIndex(int newValue) {
    _selectedProductCheckoutIndex = newValue;
    notifyListeners();
  }


  List<Product> _checkOut = [];

  List<Product> get checkOut => _checkOut;

  set setCheckOutList(List<Product> newValue) {
    _checkOut = newValue;
    notifyListeners();
  }



  final _cartBox = Hive.box("cart_box");
  List<dynamic> _cart = [];

  List<dynamic> get cart => _cart;

  set setCart(List<dynamic> newCart) {
    _cart = newCart;
    notifyListeners();
  }

  void deleteItemFromCart(int key) async {
    await _cartBox.delete(key);
  }

  Future<void> createCart(Map<String, dynamic> newCart) async {
    try {
      //when using add it is not keyed, it is auto-incremented
      await _cartBox.add(newCart);
      print("Success adding item to cart");
    } catch (e) {
      print("Error adding item to cart: ${e.toString()}");
    }
  }

  void getCartData() {
    final cartData = _cartBox.keys.map(
      (key) {
        final item = _cartBox.get(key);
        return {
          //we need the key so we can locate in hive at what key the shoes item is stored in, so we can delete it, add, decrease, etc.
          "key": key,
          "id": item["id"],
          "category": item["category"],
          "name": item["name"],
          "imageUrl": item["imageUrl"],
          "price": item["price"],
          "qty": item["qty"],
          "sizes": item["sizes"]
        };
      },
    ).toList();

    //we need to reverse the cart items, so that the latest comes on top
    _cart = cartData.reversed.toList();
    //notifylisteners  notify the listeners to update their ui/rerender with the changed values
    notifyListeners();
  }

  // int _counter = 0;

  // int get counter => _counter;

  void increment(int key) {
    final item = _cartBox.get(key);

    _cartBox.putAt(key, {
      //we need the key so we can locate in hive at what key the shoes item is stored in, so we can delete it, add, decrease, etc.
      "key": key,
      "id": item["id"],
      "category": item["category"],
      "name": item["name"],
      "imageUrl": item["imageUrl"],
      "price": item["price"],
      "qty": item["qty"] + 1,
      "sizes": item["sizes"]
    });
  }

  void decrement(int key) {
    final item = _cartBox.get(key);
    if (item["qty"] > 0) {
      _cartBox.putAt(key, {
        //we need the key so we can locate in hive at what key the shoes item is stored in, so we can delete it, add, decrease, etc.
        "key": key,
        "id": item["id"],
        "category": item["category"],
        "name": item["name"],
        "imageUrl": item["imageUrl"],
        "price": item["price"],
        "qty": item["qty"] - 1,
        "sizes": item["sizes"]
      });
    }
  }
}
