import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:flutter/material.dart';


import '../widgets/export.dart';

class ProductByCart extends StatefulWidget {
  final int tabIndex;
  const ProductByCart({super.key, required this.tabIndex});

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(initialIndex: widget.tabIndex, length: 3, vsync: this);
  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];
  
  

  void openfilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      builder: (context) {
        return Container(
          height: 682.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r))),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 5.h,
                width: 40.w,
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10.r)),
              ),
              SizedBox(
                height: 568.h,
                child: Column(
                  children: [
                    const CustomSpacer(),
                    Text(
                      "Filter",
                      style: appStyle(
                          size: 40, color: Colors.black, fw: FontWeight.bold),
                    ),
                    const CustomSpacer(),
                    Text(
                      "Gender",
                      style: appStyle(
                          size: 20, color: Colors.black, fw: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        CategoryButton(
                            onPressed: () {},
                            buttonColor: Colors.black,
                            label: "Men"),
                        CategoryButton(
                            onPressed: () {},
                            buttonColor: Colors.grey,
                            label: "Women"),
                        CategoryButton(
                            onPressed: () {},
                            buttonColor: Colors.grey,
                            label: "Kids"),
                      ],
                    ),
                    const CustomSpacer(),
                    Text("Category",
                        style: appStyle(
                            size: 20,
                            color: Colors.black,
                            fw: FontWeight.w600)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        CategoryButton(
                            onPressed: () {},
                            buttonColor: Colors.black,
                            label: "Shoes"),
                        CategoryButton(
                            onPressed: () {},
                            buttonColor: Colors.grey,
                            label: "Apparels"),
                        CategoryButton(
                            onPressed: () {},
                            buttonColor: Colors.grey,
                            label: "Access"),
                      ],
                    ),
                    const CustomSpacer(),
                    Text(
                      "Price",
                      style: appStyle(
                          size: 20, color: Colors.black, fw: FontWeight.bold),
                    ),
                    const CustomSpacer(),
                    Slider(
                      value: 100,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      thumbColor: Colors.black,
                      max: 500,
                      divisions: 50,
                      label: 100.toString(),
                      secondaryTrackValue: 200,
                      onChanged: (value) {},
                    ),
                    const CustomSpacer(),
                    Text(
                      "Brand",
                      style: appStyle(
                          size: 20, color: Colors.black, fw: FontWeight.bold),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        height: 80.h,
                        child: ListView.builder(
                          itemCount: brand.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12.r)
                                ),
                                child: Image.asset(brand[index], height: 60.h, width: 80.w, color: Colors.black)
                              ),
                            );
                          }
                        )
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProductNotifier>().getMale();
    context.read<ProductNotifier>().getFemale();
    context.read<ProductNotifier>().getKids();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        child: Consumer<ProductNotifier>(
          builder: (context, productNotifier, child) {
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
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(6.w, 12.h, 16.w, 18.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child:
                                    const Icon(Icons.close, color: Colors.white)),
                            GestureDetector(
                                onTap: () {
                                  openfilterModal();
                                },
                                child: const Icon(FontAwesomeIcons.sliders,
                                    color: Colors.white))
                          ],
                        ),
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
                Padding(
                  padding: EdgeInsets.only(
                      top: 142.h,
                      left: 16.w,
                      right: 12.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        LatestShoesCard(sneakers: productNotifier.maleSneakers),
                        LatestShoesCard(sneakers: productNotifier.femaleSneakers),
                        LatestShoesCard(sneakers: productNotifier.kidSneakers),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
