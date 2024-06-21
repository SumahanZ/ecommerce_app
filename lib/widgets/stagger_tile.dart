import 'package:ecommerce_app/widgets/export.dart';
import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:flutter/material.dart';

class StaggerTile extends StatelessWidget {
  final Sneaker sneaker;
  const StaggerTile({super.key, required this.sneaker});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16.r))),
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(sneaker.imageUrl[0], fit: BoxFit.fill),

            Container(
              padding: EdgeInsets.only(top: 12.h),
              height: 75.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(text: sneaker.name, style: appStyleWithHt(size: 20, color: Colors.black, fw: FontWeight.w700, ht: 1)),
                  SizedBox(height: 10.h),
                  ReusableText(text: "\$${sneaker.price}", style: appStyleWithHt(size: 20, color: Colors.black, fw: FontWeight.w500, ht: 1))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
