import 'package:ecommerce_app/services/config.dart';
import 'package:ecommerce_app/models/sneaker_model.dart';
import 'package:http/http.dart' as http;

class SneakerHelper {
  Future<List<Sneaker>> getSneakers({required SneakerType type}) async {
    List<Sneaker> sneakers = [];
    var url = Uri.http(Config.apiUrl, Config.sneakersUrl);

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final sneakerList = sneakersFromJson(response.body);
      switch (type) {
        case SneakerType.kid:
          sneakers = sneakerList
              .where((sneaker) => sneaker.category == "Kids' Running")
              .toList();
        case SneakerType.men:
          sneakers = sneakerList
              .where((sneaker) => sneaker.category == "Men's Running")
              .toList();
        case SneakerType.women:
          sneakers = sneakerList
              .where((sneaker) => sneaker.category == "Women's Running")
              .toList();
      }
    } else {
      throw Exception("Failed to get product list");
    }

    return sneakers;
  }


  Future<List<Sneaker>> searchSneakers({required String queryString}) async {
    var url = Uri.http(Config.apiUrl, "${Config.searchUrl}$queryString");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final sneakers = sneakersFromJson(response.body);
      return sneakers;
    } else {
      throw Exception("Failed to get product list");
    }
  }
}

enum SneakerType { kid, men, women }
