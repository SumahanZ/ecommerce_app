// ignore_for_file: sort_child_properties_last
import 'package:ecommerce_app/controllers/login_provider.dart';
import 'package:ecommerce_app/services/cart_helper.dart';
import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:flutter/material.dart';
import '../models/add_to_cart.dart';
import '../widgets/export.dart';
import 'auth/login_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Sneaker sneaker;
  const ProductDetailPage({super.key, required this.sneaker});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<FavoritesNotifier>().getFavorites();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<LoginNotifier>();
    return Scaffold(
        //customscrollview allows us to use multiple slivers
        body: Consumer<ProductNotifier>(
      builder: (context, productNotifier, child) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: true,
              backgroundColor: Colors.transparent,
              expandedHeight: 825.h,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    SizedBox(
                      height: 401.h,
                      width: 375.w,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.sneaker.imageUrl.length,
                        controller: pageController,
                        onPageChanged: (page) {
                          productNotifier.setActivePage = page;
                        },
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                  height: 316.h,
                                  width: 375.w,
                                  color: Colors.grey.shade300,
                                  child: Image.network(
                                      widget.sneaker.imageUrl[index],
                                      fit: BoxFit.contain)),
                    
                              //if right 0 and left 0, it will be positioned in the center
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                height: 280.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List<Widget>.generate(
                                    widget.sneaker.imageUrl.length,
                                    (index) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.w),
                                      child: CircleAvatar(
                                          radius: 5.r,
                                          backgroundColor:
                                              productNotifier.activePage ==
                                                      index
                                                  ? Colors.black
                                                  : Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Positioned(
                        bottom: 30.h,
                        child: ClipRRect(
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(12.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.sneaker.name,
                                      style: appStyle(
                                          size: 32,
                                          color: Colors.black,
                                          fw: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          widget.sneaker.category,
                                          style: appStyle(
                                              size: 20,
                                              color: Colors.grey,
                                              fw: FontWeight.bold),
                                        ),
                                        SizedBox(width: 20.w),
                                        RatingBar.builder(
                                            initialRating: 4,
                                            minRating: 1,
                                            itemCount: 5,
                                            itemSize: 22,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 1.w),
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemBuilder: (context, index) {
                                              return const Icon(Icons.star,
                                                  size: 18,
                                                  color: Colors.black);
                                            },
                                            onRatingUpdate: (rating) {})
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\$${widget.sneaker.price}",
                                          style: appStyle(
                                              size: 26,
                                              color: Colors.black,
                                              fw: FontWeight.w600),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Colors",
                                              style: appStyle(
                                                  size: 18,
                                                  color: Colors.black,
                                                  fw: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            CircleAvatar(
                                              radius: 7.r,
                                              backgroundColor: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            CircleAvatar(
                                              radius: 7.r,
                                              backgroundColor: Colors.red,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Select sizes",
                                              style: appStyle(
                                                  size: 20,
                                                  color: Colors.black,
                                                  fw: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Text(
                                              "View size guide",
                                              style: appStyle(
                                                  size: 18,
                                                  color: Colors.grey,
                                                  fw: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),

                                        //since we are using jsondata we have to pass the data to a provider, so we can choose multiple sizes
                                        SizedBox(
                                          height: 40.h,
                                          child: ListView.builder(
                                            itemCount: productNotifier
                                                .shoeSizes.length,
                                            scrollDirection: Axis.horizontal,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0.w),
                                                child: ChoiceChip(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60.r),
                                                    ),
                                                    disabledColor: Colors.white,
                                                    selectedColor: Colors.black,
                                                    label: Text(
                                                      productNotifier
                                                              .shoeSizes[index]
                                                          ["size"],
                                                      style: appStyle(
                                                          size: 16,
                                                          color: productNotifier
                                                                          .shoeSizes[
                                                                      index]
                                                                  ["isSelected"]
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fw: FontWeight.w500),
                                                    ),
                                                    onSelected: (selected) {
                                                      productNotifier
                                                          .toggleCheck(index);
                                                    },
                                                    selected: productNotifier
                                                            .shoeSizes[index]
                                                        ["isSelected"]),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    const Divider(
                                      indent: 10,
                                      endIndent: 10,
                                      color: Colors.black,
                                    ),
                                    SizedBox(height: 10.h),
                                    SizedBox(
                                      width: 300.w,
                                      child: Text(
                                        widget.sneaker.title,
                                        style: appStyle(
                                            size: 20,
                                            color: Colors.black,
                                            fw: FontWeight.w700),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(widget.sneaker.description,
                                        style: appStyle(
                                            size: 12,
                                            color: Colors.black,
                                            fw: FontWeight.normal),
                                        maxLines: 4,
                                        textAlign: TextAlign.justify),
                                    SizedBox(height: 10.h),
                                    CheckoutButton(
                                      label: "Add to Cart",
                                      onTap: () {
                                        if (authNotifier.loggedIn == true) {
                                          //the cartitem will be the id
                                          print("Test");
                                         AddToCart model = AddToCart(cartItemId: widget.sneaker.id, quantity: 1);
                                         CartHelper().addToCart(model);
                                        } else {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return const LoginPage();
                                              },
                                            ),
                                          );
                                        }
                                        // final filteredSizes = productNotifier
                                        //     .shoeSizes
                                        //     .where((element) =>
                                        //         element["isSelected"] == true)
                                        //     .toList()
                                        //     .map((e) => e["size"])
                                        //     .toList();

                                        // context
                                        //     .read<CartNotifier>()
                                        //     .createCart({
                                        //   "id": widget.sneaker.id,
                                        //   "name": widget.sneaker.name,
                                        //   "category": widget.sneaker.category,
                                        //   "sizes": filteredSizes,
                                        //   "imageUrl":
                                        //       widget.sneaker.imageUrl[0],
                                        //   "price": widget.sneaker.price,
                                        //   "qty": 1
                                        // });

                                        // productNotifier.shoeSizes.clear();
                                        // Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              height: 560.h,
                              width: 375.w,
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                topRight: Radius.circular(30.r))))
                  ],
                ),
              ),
              automaticallyImplyLeading: false,
              leadingWidth: 0,
              title: Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //when we close, we also want to clear the list in the provider
                        Navigator.of(context).pop();
                        //we don;t want to notifyListeners when clearing because we are not displaying in here again when we empty, we clear the list (we are not in the detail page anymore)
                        productNotifier.shoeSizes.clear();
                      },
                      child: const Icon(Icons.close, color: Colors.black),
                    ),
                    Consumer<FavoritesNotifier>(
                        builder: (context, favoritesNotifier, child) {
                      return GestureDetector(
                        onTap: () {
                          if (authNotifier.loggedIn) {
                            if (favoritesNotifier.ids
                                .contains(widget.sneaker.id)) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const FavoritePage();
                                  },
                                ),
                              );
                            } else {
                              favoritesNotifier.createFav(
                                {
                                  "id": widget.sneaker.id,
                                  "name": widget.sneaker.name,
                                  "category": widget.sneaker.category,
                                  "price": widget.sneaker.price,
                                  "imageUrl": widget.sneaker.imageUrl[0]
                                },
                              );
                            }
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LoginPage();
                                },
                              ),
                            );
                          }
                        },
                        child: favoritesNotifier.ids.contains(widget.sneaker.id)
                            ? const Icon(CupertinoIcons.heart_fill,
                                color: Colors.black)
                            : const Icon(CupertinoIcons.heart,
                                color: Colors.black),
                      );
                    })
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ));
  }
}
