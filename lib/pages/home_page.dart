import 'package:ecommerce_app/controllers/login_provider.dart';
import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:flutter/material.dart';
import '../widgets/export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
    context.read<ProductNotifier>().getMale();
    context.read<ProductNotifier>().getFemale();
    context.read<ProductNotifier>().getKids();
    //we need to hook this getPrefs in the homepage because the HomePage is the first screen people go into, so we check if there if there is a current user logged in
    //then we can authenticate them if not display the non-authenticated page when trying to access specific authenticated pages
    context.read<LoginNotifier>().getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body:
          Consumer<ProductNotifier>(builder: (context, productNotifier, child) {
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 45.h, 0, 0),
              height: 325.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/top_image.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 8.w, bottom: 15.h),
                width: 375.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: "Athletics Shoes",
                      style: appStyleWithHt(
                          size: 42,
                          color: Colors.white,
                          fw: FontWeight.bold,
                          ht: 1.5),
                    ),
                    Text(
                      "Collection",
                      style: appStyleWithHt(
                          size: 42,
                          color: Colors.white,
                          fw: FontWeight.bold,
                          ht: 1.2),
                    ),
                    TabBar(
                      padding: const EdgeInsets.all(0),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Colors.white,
                      labelStyle: appStyle(
                          size: 24, color: Colors.white, fw: FontWeight.bold),
                      unselectedLabelColor: Colors.grey.withOpacity(0.3),
                      tabs: const [
                        Tab(text: "Men Shoes"),
                        Tab(text: "Women Shoes"),
                        Tab(text: "Kids Shoes")
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 220.h),
              child: Container(
                padding: EdgeInsets.only(left: 12.w),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    HomeWidget(
                      sneakers: productNotifier.maleSneakers,
                      tabIndex: 0,
                    ),
                    HomeWidget(
                      sneakers: productNotifier.femaleSneakers,
                      tabIndex: 1,
                    ),
                    HomeWidget(
                      sneakers: productNotifier.kidSneakers,
                      tabIndex: 2,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
