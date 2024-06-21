import 'dart:convert';

String addToCartToJson(AddToCart data) => json.encode(data.toJson());

class AddToCart {
    String cartItemId;
    int quantity;

    AddToCart({
        required this.cartItemId,
        required this.quantity,
    });


    Map<String, dynamic> toJson() => {
        "cartItem": cartItemId,
        "quantity": quantity,
    };
}
