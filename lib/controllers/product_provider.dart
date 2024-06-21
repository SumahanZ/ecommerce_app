
import 'package:ecommerce_app/services/sneaker_helper.dart';
import 'package:flutter/material.dart';
import '../widgets/export.dart';

class ProductNotifier with ChangeNotifier {
  final service = SneakerHelper();
  int _activePage = 0;
  //the reason we had to do this is because we want to freely manipulate the data ourselves, if we manipulate directly from the json, whats the use, the jsondata is only to read from it
  //therefore we created another copy that is mutable/that we can change
  List<dynamic> _shoeSizes = [];
  late Future<List<Sneaker>> maleSneakers;
  late Future<List<Sneaker>> femaleSneakers;
  late Future<List<Sneaker>> kidSneakers;
  late Future<Sneaker?> sneaker;

  List<dynamic> get shoeSizes => _shoeSizes;
  int get activePage => _activePage;


  // void getShoes({required String category, required String id}) {
  //   if (category == "Men's Running") {
  //     sneaker = service.getSneakerById(type: SneakerType.men, id: id);
  //   } else if (category == "Women's Running") {
  //     sneaker = service.getSneakerById(type: SneakerType.women, id: id);
  //   } else {
  //     sneaker = service.getSneakerById(type: SneakerType.kid, id: id);
  //   }
  // }

  set setActivePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }

  set setShoeSizes(List<dynamic> newSizes) {
    _shoeSizes = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index) {
    //index here will be the index of the tapped choicechip
    for (int i = 0; i < _shoeSizes.length; i++) {
      if (i == index) {
        //negate the state, for example isSelected is true it will be changed to false
        //and vice versa
        _shoeSizes[i]["isSelected"] = !_shoeSizes[i]["isSelected"];
      }
    }
    notifyListeners();
  }

  void getMale() {
    maleSneakers = service.getSneakers(type: SneakerType.men);
  }

  void getFemale() {
    femaleSneakers = service.getSneakers(type: SneakerType.women);
  }

  void getKids() {
    kidSneakers = service.getSneakers(type: SneakerType.kid);
  }
}
