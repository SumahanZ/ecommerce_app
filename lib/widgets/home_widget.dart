

import 'package:ecommerce_app/widgets/export.dart';
import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  final Future<List<Sneaker>> sneakers;
  final int tabIndex;

  const HomeWidget({super.key, required this.sneakers, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    // final productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      children: [
        SizedBox(
          height: 325.h,
          child: FutureBuilder(
            future: sneakers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator.adaptive());
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final sneaker = snapshot.data!;
                return Consumer<ProductNotifier>(
                  builder: (context, productNotifier, child) {
                    return ListView.builder(
                      itemCount: sneaker.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              productNotifier.setShoeSizes = sneaker[index].sizes;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProductDetailPage(sneaker: sneaker[index],);
                                  },
                                ),
                              );
                            },
                            child: ProductCard(sneaker: sneaker[index]));
                      },
                    );
                  }
                );
              }
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding:  EdgeInsets.fromLTRB(12.w, 20.h, 12.w, 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: "Latest Shoes",
                    style: appStyle(
                        size: 24, color: Colors.black, fw: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductByCart(
                              tabIndex: tabIndex,
                            );
                          },
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        ReusableText(
                          text: "Show All",
                          style: appStyle(
                              size: 22,
                              color: Colors.black,
                              fw: FontWeight.w500),
                        ),
                        Icon(Icons.play_arrow, size: 30.h),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 99.h,
          child: FutureBuilder(
            future: sneakers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final sneaker = snapshot.data!;
                return ListView.builder(
                  itemCount: sneaker.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0.h),
                      child: NewShoes(imageUrl: sneaker[index].imageUrl[1]),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
