import 'package:ecommerce_app/controllers/login_provider.dart';
import 'package:ecommerce_app/pages/auth/login_page.dart';
import 'package:ecommerce_app/widgets/export.dart';
import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.sneaker});

  final Sneaker sneaker;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool selected = true;

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
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 0, 20.w, 0),
      //cliprrect allows use to add borderradius to our widget
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16.h)),
        child: Container(
          height: 325.h,
          width: 225.w,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1)),
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 186.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.sneaker.imageUrl[0]),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10.w,
                    top: 10.h,
                    child: Consumer<FavoritesNotifier>(
                        builder: (context, favoritesNotifier, child) {
                      return GestureDetector(
                        onTap: () {
                          if (authNotifier.loggedIn) {
                            //if the id is in our list, we are going to navigate to our favorite list so we can delete from there
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
                                  "imageUrl": widget.sneaker.imageUrl
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
                            ? const Icon(CupertinoIcons.heart_fill)
                            : const Icon(CupertinoIcons.heart),
                      );
                    }),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: widget.sneaker.name,
                      style: appStyleWithHt(
                          size: 28,
                          color: Colors.black,
                          fw: FontWeight.bold,
                          ht: 1.1),
                    ),
                    ReusableText(
                      text: widget.sneaker.category,
                      style: appStyleWithHt(
                          size: 18,
                          color: Colors.grey,
                          fw: FontWeight.bold,
                          ht: 1.5),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${widget.sneaker.price}",
                      style: appStyle(
                          size: 24, color: Colors.black, fw: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        ReusableText(
                          text: "Colors",
                          style: appStyle(
                              size: 18,
                              color: Colors.grey,
                              fw: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        ChoiceChip(
                          label: const Text(" "),
                          selected: selected,
                          visualDensity: VisualDensity.compact,
                          selectedColor: Colors.black,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
