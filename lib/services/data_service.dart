// import 'package:flutter/services.dart' as the_bundle;
// import 'package:ecommerce_app/models/sneaker_model.dart';

// class DataService {

//   Future<List<Sneaker>> getSneakers({required SneakerType type}) async {
//     String jsonPath;

//     switch (type) {
//       case SneakerType.kid:
//       jsonPath = "assets/json/kids_shoes.json";
//       case SneakerType.men:
//       jsonPath = "assets/json/men_shoes.json";
//       case SneakerType.women:
//       jsonPath = "assets/json/women_shoes.json";
//     }

//     //load json from local file
//     final data = await the_bundle.rootBundle.loadString(jsonPath);

//     final dataList = sneakersFromJson(data);

//     return dataList;
//   }


//   Future<Sneaker?> getSneakerById({required SneakerType type, required String id}) async {
//     String jsonPath;

//     switch (type) {
//       case SneakerType.kid:
//       jsonPath = "assets/json/kid_shoes.json";
//       case SneakerType.men:
//       jsonPath = "assets/json/men_shoes.json";
//       case SneakerType.women:
//       jsonPath = "assets/json/women_shoes.json";
//     }
//     //load json from local file
//     final data = await the_bundle.rootBundle.loadString(jsonPath);

//     final dataList = sneakersFromJson(data);

//     final sneaker = dataList.firstWhere((element) => element.id == id);

//     return sneaker;
//   }
// }

// enum SneakerType {
//   kid, men, women
// }