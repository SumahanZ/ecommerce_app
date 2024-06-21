import 'package:ecommerce_app/widgets/export.dart';
import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, value, widget) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomNavWidget(
                  icon: value.pageIndex == 0 ? Ionicons.home : Ionicons.home_outline,
                  onTap: () => value.pageIndex = 0,
                ),
                BottomNavWidget(
                  icon: value.pageIndex == 1 ? Ionicons.search : Ionicons.search,
                  onTap: () => value.pageIndex = 1,
                ),
                BottomNavWidget(
                  icon: value.pageIndex == 2 ? Ionicons.heart : Ionicons.heart_circle_outline,
                  onTap: () => value.pageIndex = 2,
                ),
                //we want to protect the cart
                // BottomNavWidget(
                //   icon: value.pageIndex == 3 ? Ionicons.cart : Ionicons.cart_outline,
                //   onTap: () => value.pageIndex = 3,
                // ),
                BottomNavWidget(
                  icon: value.pageIndex == 3 ? Ionicons.person : Ionicons.person_outline,
                  onTap: () => value.pageIndex = 3,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}