import 'dart:convert';

import 'package:ecommerce_app/services/config.dart';
import 'package:http/http.dart' as https;

import '../models/orders/orders_req.dart';

class PaymentHelper {
  Future<String> payment(Order model) async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };
    var url = Uri.https(Config.paymentBaseUrl, Config.paymentUrl);
    var response = await https.post(url, headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      final payment = jsonDecode(response.body);
      print(payment);
      return payment["url"];
    } else {
      return "failed";
    }
  }
}