import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BottomNavWidget extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  const BottomNavWidget({
    super.key, required this.icon, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 36,
        width: 36,
        child: Icon(icon, color: Colors.white)
      ),
    );
  }
}