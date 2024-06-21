import 'package:flutter/material.dart';
import '../widgets/export.dart';
import '../widgets/export_packages.dart';

class MainPage extends StatelessWidget {
  final pageList =  [
    const HomePage(),
    const SearchPage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(builder: (context, value, widget) {
      return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: pageList[value.pageIndex],
        bottomNavigationBar: const BottomNavBar(),
      );
    });
  }
}
