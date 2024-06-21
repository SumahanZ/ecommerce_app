import 'package:ecommerce_app/utilities/appstyle.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final void Function() onPressed;
  final Color buttonColor;
  final String label;
  const CategoryButton({super.key, required this.onPressed, required this.buttonColor, required this.label});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.255,
        decoration: BoxDecoration(
          border: Border.all(
            color: buttonColor, 
            style: BorderStyle.solid, 
          ),
          borderRadius: BorderRadius.circular(9)
        ),
        child: Center(child: Text(label, style: appStyle(size: 20, color: buttonColor, fw: FontWeight.w600)))
      ),
    );
  }
}
