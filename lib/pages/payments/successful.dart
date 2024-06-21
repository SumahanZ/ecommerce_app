import 'package:ecommerce_app/controllers/payment_provider.dart';
import 'package:ecommerce_app/pages/main_page.dart';
import 'package:ecommerce_app/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

import 'package:provider/provider.dart';

import '../../utilities/appstyle.dart';

class Successful extends StatelessWidget {
  const Successful({super.key});

  @override
  Widget build(BuildContext context) {
    var paymentNotifier = Provider.of<PaymentNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            paymentNotifier.paymentUrl = '';
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          },
          child: const Icon(
            AntDesign.closecircleo,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/Checkmark.png"),
            ReusableText(
                text: "Payment Successful",
                style: appStyle(size: 28, color: Colors.black, fw: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
