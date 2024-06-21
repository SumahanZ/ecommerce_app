import 'package:ecommerce_app/utilities/appstyle.dart';
import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  final String label;
  final void Function() onTap;
  const CheckoutButton({
    super.key, required this.label, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16)
          ),
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: Text(label, style: appStyle(size: 20, color: Colors.white, fw: FontWeight.bold)),
          )
        )
      )
    );
  }
}