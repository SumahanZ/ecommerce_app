import 'dart:convert';

List<Sneaker> sneakersFromJson(String str) => List<Sneaker>.from(json.decode(str).map((x) => Sneaker.fromJson(x)));

String sneakersToJson(List<Sneaker> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sneaker {
    final String id;
    final String name;
    final String title;
    final String category;
    final List<dynamic> imageUrl;
    final String oldPrice;
    final List<dynamic> sizes;
    final String price;
    final String description;

    Sneaker({
        required this.id,
        required this.name,
        required this.title,
        required this.category,
        required this.imageUrl,
        required this.oldPrice,
        required this.sizes,
        required this.price,
        required this.description,
    });

    factory Sneaker.fromJson(Map<String, dynamic> json) => Sneaker(
        id: json["_id"],
        name: json["name"],
        title: json["title"],
        category: json["category"],
        imageUrl: List<dynamic>.from(json["imageUrl"].map((x) => x)),
        oldPrice: json["oldPrice"],
        sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
        price: json["price"],
        description: json["description"],
    );

    //when to json you need tot ransform into List<dynamic> instead of List<Sizes>
    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "title": title,
        "category": category,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "oldPrice": oldPrice,
        "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
        "price": price,
        "description": description,
    };
}

class Sizes {
    final String size;
    bool isSelected;
    final String id;

    Sizes({
        required this.size,
        required this.isSelected,
        required this.id,
    });

    factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
        size: json["size"],
        isSelected: json["isSelected"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "size": size,
        "isSelected": isSelected,
        "_id": id,
    };
}
