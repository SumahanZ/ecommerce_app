import 'package:ecommerce_app/controllers/login_provider.dart';
import 'package:ecommerce_app/pages/notauthenticateduser_page.dart';
import 'package:ecommerce_app/widgets/export.dart';
import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  @override
  void initState() {
    super.initState();
    context.read<FavoritesNotifier>().getAllData();
  }
  
  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<LoginNotifier>();
    return authNotifier.loggedIn ? Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 45.h, 0, 0),
            width: 375.w,
            height: 320.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/top_image.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: Text(
                "My Favorites",
                style: appStyle(
                    size: 40, color: Colors.white, fw: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.h),
            child: Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                return ListView.builder(
                  padding: EdgeInsets.only(top: 100.h),
                  itemCount: favoritesNotifier.fav.length,
                  itemBuilder: (context, index) {
                    final shoe = favoritesNotifier.fav[index];
                    return Padding(
                      padding: EdgeInsets.all(8.h),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          height: 110.h,
                          width: 375.w,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade500,
                                  spreadRadius: 5,
                                  blurRadius: 0.3,
                                  offset: const Offset(0, 1))
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12.h),
                                    child: Image.network(
                                      shoe["imageUrl"][0],
                                      width: 70.w,
                                      height: 70.h,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 12.h, left: 20.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          shoe["name"],
                                          style: appStyle(
                                              size: 16,
                                              color: Colors.black,
                                              fw: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          shoe["category"],
                                          style: appStyle(
                                              size: 14,
                                              color: Colors.grey,
                                              fw: FontWeight.w600),
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '\$${shoe["price"]}',
                                              style: appStyle(
                                                  size: 18,
                                                  color: Colors.black,
                                                  fw: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.h),
                                child: GestureDetector(
                                  onTap: () {
                                    favoritesNotifier.deleteItemFromFavorite(shoe["key"]);
                                    favoritesNotifier.ids.removeWhere(
                                        (element) => element == shoe["id"]);
                                        
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return MainPage();
                                        },
                                      ),
                                    );
                                  },
                                  child: const Icon(Ionicons.heart_dislike),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    ) : const NonAuthenticatedPage();
  }
}
